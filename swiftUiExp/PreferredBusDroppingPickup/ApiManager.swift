import Foundation
class ApiManager {
    typealias CompletionHandler<T: Decodable> = (Result<T, Error>) -> Void
    private init(){}
    static let shared = ApiManager()
   
    func fetchApiResult<T: Decodable>(urlString: String, method: String, body: [String: Any], completionHandler: @escaping CompletionHandler<T>) {
           guard let url = URL(string: urlString) else {
               print("Invalid URL")
               return
           }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.timeoutInterval = .infinity
        if method == "POST" {
            do {
                var jsonBody = try JSONSerialization.data(withJSONObject: body, options: [])
                request.httpBody = jsonBody
            }catch{
                print("Error occurred")
            }
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error with fetching films: \(error)")
                completionHandler(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(response)")
                completionHandler(.failure(NSError(domain: "HTTP Error", code: (response as? HTTPURLResponse)?.statusCode ?? 0, userInfo: nil)))
                return
            }
            
            if let data = data {
                do {
                    let filmSummary = try JSONDecoder().decode(T.self, from: data)
//                    print(filmSummary)
                    completionHandler(.success(filmSummary))
                    
                } catch {
                    print("Error decoding JSON: \(error)")
                    completionHandler(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}
