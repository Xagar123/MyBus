//
//  PreferredBusPartnerViewModel.swift
//  swiftUiExp
//
//  Created by Sagar on 19/06/24.
//

import Foundation
import Combine
import SwiftUI


class PreferredBusPartnerViewModel: ObservableObject {
    @StateObject var viewModels = BusServiceViewModel()
    @Published var PreferredBusPartnerSearchText : String = ""
    @Published var fetchBusPartner: [Operators] = []
    @Published var fetchDroppingAndPickUpPoint : [BusService] = []
    @Published var errorMessage: ErrorWrapper?
    private var cancellables: Set<AnyCancellable> = []
    @Published var selectedItem: Set<Operators> = []
    @Published var preferredBusPartnerSearchResult : [Operators]?
    @Published var preferredDroppingPickUPPointSearchResult : [BusService]?
    @State var selectedItems  =  [Operators]()
    var pageType : ScreenType?
    
    func fetchData(){
        
        switch pageType{
        case .preferredBusPartner:
            fetchBusPartners()
        case .PreferredDroppingPoint:
            viewModels.availableBusService(source: 3, destination: 5, date: "2024-06-18")
        case .PreferredPickupPoint :
            viewModels.availableBusService(source: 3, destination: 5, date: "2024-06-18")
        case .none:
            break
            
        }
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
                    preferredBusPartnerSearchResult = nil
                    preferredDroppingPickUPPointSearchResult = nil
                    return
                }
                switch pageType {
                    
                case .preferredBusPartner:
                    self.preferredBusPartnerSearchResult = fetchBusPartner.filter { operatr in
                        if operatr.operater_name.contains(searchText) {
                            return true
                        }
                        return false
                        //                    self.searchResult = nil
                    }
                case .PreferredPickupPoint:
                    self.preferredDroppingPickUPPointSearchResult = fetchDroppingAndPickUpPoint.filter { operatr in
                        if operatr.boardingInfo.contains(searchText) {
                            return true
                        }
                        return false
                        //                    self.searchResult = nil
                    }
                case .PreferredDroppingPoint:
                    self.preferredDroppingPickUPPointSearchResult = fetchDroppingAndPickUpPoint.filter { operatr in
                        if operatr.droppingInfo.contains(searchText) {
                            return true
                        }
                        return false
                        //                    self.searchResult = nil
                    }
                }
                
            }
            .store(in: &cancellables)
    }
 
    func toggleSelection(of item: Operators) {
            if let index = preferredBusPartnerSearchResult?.firstIndex(where: { $0.operator_id == item.operator_id }) {
                preferredBusPartnerSearchResult?[index].isSelected?.toggle()
            }
        }
}
struct ErrorWrapper: Identifiable {
    let id = UUID()
    let message: String
}
