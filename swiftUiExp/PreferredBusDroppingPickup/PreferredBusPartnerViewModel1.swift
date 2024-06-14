//import Foundation
//import Combine
//import SwiftUI
//
//
//class PreferredBusPartnerViewModel: ObservableObject {
//    
//    @Published var PreferredBusPartnerSearchText : String = ""
//    @Published var fetchBusPartner: [Operators] = []
//    @Published var fetchDroppingAndPickUpPoint : [Services] = []
//    @Published var errorMessage: ErrorWrapper?
//    private var cancellables: Set<AnyCancellable> = []
//    @Published var selectedItem: Set<Operators> = []
//    @Published var preferredBusPartnerSearchResult : [Operators]?
//    @Published var preferredDroppingPickUPPointSearchResult : [Services]?
//    @State var selectedItems  =  [Operators]()
//    @Published var refundPolicy : [RefundPolicies] = []
//    var pageType : ScreenType?
//    
//    func fetchData(){
//        
//        switch pageType{
//        case .preferredBusPartner:
//            print("print")
//            fetchBusPartners()
//        case .PreferredDroppingPoint:
//            fetchDroppingPoints()
//            
//        case .PreferredPickupPoint :
//            fetchDroppingPoints()
//        case .none:
//            break
//            
//        }
//    }
//    func fetchBusPartners() {
//        print("calling")
//        ApiManager.shared.fetchApiResult(urlString: "https://api.mynpro.xyz/bus/user/api/abhibus/operators", method: "GET", body: [
//            "operatorId": 465,
//            "serviceId": 1357918385,
//            "sourceStationId": 3,
//            "destinationStationId": 5,
//            "journeyDate": "2023-12-29"
//        ]) { (result: Result<preferredBus, Error>) in
//            DispatchQueue.main.async {
//                
//                
//                switch result{
//                    
//                case .success(let model):
//                    self.fetchBusPartner = model.operatorsInfo
//                case .failure(_):
//                    print(ErrorWrapper(message: "its error"))
//                }
//            }
//        }
//    }
//    func fetchDroppingPoints(){
//        ApiManager.shared.fetchApiResult(urlString:"https://api.mynpro.xyz/bus/user/api/abhibus/available-services", method: "POST", body: [
//                      "source": 5,
//                      "destination": 3,
//                      "date": "2024-06-13"
//        ]) { (result: Result<PreferredDropping, Error>) in
//            DispatchQueue.main.async {
//                
//                
//                switch result{
//                    
//                case .success(let model):
//                    self.fetchDroppingAndPickUpPoint = model.services
////                    print(model)
//                case .failure(_):
//                    print(ErrorWrapper(message: "its error"))
//                }
//            }
//        }
//        
//    }
//    func fetchRefundPolicy(){
//        ApiManager.shared.fetchApiResult(urlString: "https://api.mynpro.xyz/bus/user//api/abhibus/cancellation-policy/?operatorId=111631&serviceId=1358044561&sourceStationId=5&destinationStationId=3&journeyDate=2024-06-14", method: "GET", body: [:]) { (result: Result<RefundPolicies, Error>) in
//            DispatchQueue.main.async {
//                
//                
//                switch result{
//                    
//                case .success(let model):
//                    self.refundPolicy = [model]
//                    print(model)
//                case .failure(_):
//                    print(ErrorWrapper(message: "its error"))
//                }
//            }
//        }
//        }
//    
//        
//       
//    
//    
//    func searchEnable(pageType: ScreenType) {
//        
//        $PreferredBusPartnerSearchText
//            .combineLatest($fetchBusPartner, $fetchDroppingAndPickUpPoint)
//            .sink { [weak self] (searchText, fetchBusPartner, fetchDroppingAndPickUpPoint ) in
//                guard let self = self else { return }
//                guard searchText != "" else {
//                    preferredBusPartnerSearchResult = nil
//                    preferredDroppingPickUPPointSearchResult = nil
//                    return
//                }
//                switch pageType {
//                    
//                case .preferredBusPartner:
//                    self.preferredBusPartnerSearchResult = fetchBusPartner.filter { operatr in
//                        if operatr.operater_name.contains(searchText) {
//                            return true
//                        }
//                        return false
//                        //                    self.searchResult = nil
//                    }
//                case .PreferredPickupPoint:
//                    self.preferredDroppingPickUPPointSearchResult = fetchDroppingAndPickUpPoint.filter { operatr in
//                        if operatr.boarding_info.contains(searchText) {
//                            return true
//                        }
//                        return false
//                        //                    self.searchResult = nil
//                    }
//                case .PreferredDroppingPoint:
//                    self.preferredDroppingPickUPPointSearchResult = fetchDroppingAndPickUpPoint.filter { operatr in
//                        if operatr.dropping_info.contains(searchText) {
//                            return true
//                        }
//                        return false
//                        //                    self.searchResult = nil
//                    }
//                }
//                
//            }
//            .store(in: &cancellables)
//    }
// 
//    func toggleSelection(of item: Operators) {
//            if let index = preferredBusPartnerSearchResult?.firstIndex(where: { $0.operator_id == item.operator_id }) {
//                preferredBusPartnerSearchResult?[index].isSelected?.toggle()
//            }
//        }
//}
//struct ErrorWrapper: Identifiable {
//    let id = UUID()
//    let message: String
//}
//
