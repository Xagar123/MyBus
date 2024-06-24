import Foundation
import Combine
import SwiftUI
class PreferredBusPartnerViewModel: ObservableObject {
    
    
    // MARK: - Properties
    @StateObject var viewModels = BusServiceViewModel()
    @Published var PreferredBusPartnerSearchText : String = ""
    @Published var fetchBusPartner: [Operators] = []
    @Published var fetchDroppingAndPickUpPoint : [BusService] = []
    @Published var errorMessage: ErrorWrapper?
    private var cancellables: Set<AnyCancellable> = []
    @Published var selectedItem: Set<Operators> = []
    @Published var preferredBusPartnerSearchResult : [Operators] = []
    @Published var preferredDroppingPickUPPointSearchResult : [BusService] = []
    @State var selectedItems  =  [Operators]()
    @Published var searchInDroppingAndPickup = [String]()
    @Published var UniqueLocations = [String]()
    var pageType : ScreenType?

    
    func fetchData(){
        
        switch pageType{
        case .preferredBusPartner:
            fetchBusPartners()
        case .PreferredDroppingPoint:
            self.availableBusService(source: 3, destination: 5, date: "2024-06-24")
        case .PreferredPickupPoint :
            self.availableBusService(source: 3, destination: 5, date: "2024-06-24")
        case .none:
            break
            
        }
    }
    
    func availableBusService(source: Int, destination: Int, date: String) {
       
        let urlString = "https://api.mynpro.xyz/bus/user/api/abhibus/available-services"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "source": source,
            "destination": destination,
            "date": date
        ]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            print("Error encoding parameters: \(error)")
            return
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }
            do {
                let decoder = JSONDecoder()
                print(try? JSONSerialization.jsonObject(with: data))
                let response = try decoder.decode(BusServiceResponse.self, from: data)
                let busList = response.services
             //   print(busList)
                //parsePickupLocations(from: busList[9].boardingInfo)
//              pickupPointList =
                DispatchQueue.main.async {
                    self.preferredDroppingPickUPPointSearchResult = busList
//                    self.sortedBusServices = busList
//                    self.hasFetchedData = true
                    self.fetchDroppingAndPickUpPoint = busList
                }
            } catch {
                print("Error parsing JSON: \(error)")

            }
        }
        task.resume()
    }
    
    func fetchBusPartners() {
        print("calling")
        ApiManager.shared.fetchApiResult(urlString: "https://api.mynpro.xyz/bus/user/api/abhibus/operators", method: "GET", body: [
            "operatorId": 465,
            "serviceId": 1357918385,
            "sourceStationId": 3,
            "destinationStationId": 5,
            "journeyDate": "2024-06-19"
        ]) { (result: Result<preferredBus, Error>) in
            DispatchQueue.main.async {
                switch result{
                    
                case .success(let model):
                    self.fetchBusPartner = model.operatorsInfo
                    self.preferredBusPartnerSearchResult = self.fetchBusPartner
                case .failure(_):
                    print(ErrorWrapper(message: "its error"))
                }
            }
        }
    }

    func searchEnable(pageType: ScreenType) {
        
        $PreferredBusPartnerSearchText
            .combineLatest($fetchBusPartner, $fetchDroppingAndPickUpPoint)
            .sink { [weak self] (searchText, fetchBusPartner, fetchDroppingAndPickUpPoint ) in
                guard let self = self else { return }
                guard searchText != "" else {
                    preferredBusPartnerSearchResult = fetchBusPartner
                    preferredDroppingPickUPPointSearchResult = fetchDroppingAndPickUpPoint
                    return
                }
                switch pageType {
                    
                case .preferredBusPartner:
                    self.preferredBusPartnerSearchResult = fetchBusPartner.filter { operatr in
                        if operatr.operater_name.contains(searchText) {
                            return true
                        }
                        return false
                    }
                case .PreferredPickupPoint:
                    self.searchInDroppingAndPickup = UniqueLocations.filter { str in
                        if str.contains(searchText) {
                            return true
                        }
                        return false
                    }
                case .PreferredDroppingPoint:
                    self.searchInDroppingAndPickup = UniqueLocations.filter { str in
                        if str.contains(searchText) {
                            return true
                        }
                        return false
                    }
                }
                
            }
            .store(in: &cancellables)
    }
 
    func toggleSelection(of item: Operators) {
            if let index = preferredBusPartnerSearchResult.firstIndex(where: { $0.operator_id == item.operator_id }) {
                preferredBusPartnerSearchResult[index].isSelected?.toggle()
            }
        }
}
struct ErrorWrapper: Identifiable {
    let id = UUID()
    let message: String
}
