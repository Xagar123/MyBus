import Foundation

// MARK: - ApiManager

final class ApiManager {
    typealias CompletionHandler<T: Decodable> = (Result<T, Error>) -> Void
    
    // Singleton instance
    static let shared = ApiManager()
    
    // Private initializer to prevent instantiation
    private init() {}
    
    // MARK: - Public Methods
    
    func fetchApiResult<T: Decodable>(urlString: String, method: String = "GET", body: [String: Any] = [:], completionHandler: @escaping CompletionHandler<T>) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.timeoutInterval = .infinity
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if method == "POST" {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                print("Error occurred while serializing JSON: \(error)")
                completionHandler(.failure(error))
                return
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error with fetching data: \(error)")
                completionHandler(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                print("Unexpected status code: \(statusCode)")
                let httpError = NSError(domain: "HTTP Error", code: statusCode, userInfo: nil)
                completionHandler(.failure(httpError))
                return
            }
            
            guard let data = data else {
                let dataError = NSError(domain: "Data Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                print("No data received")
                completionHandler(.failure(dataError))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(decodedData))
            } catch {
                print("Error decoding JSON: \(error)")
                completionHandler(.failure(error))
            }
        }
        
        task.resume()
    }
}
