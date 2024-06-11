//
//  HorizontalFilterViewModel.swift
//  swiftUiExp
//
//  Created by Sagar on 07/06/24.
//

import Foundation
import SwiftUI

class FilterViewModel: ObservableObject {
    
    @Published var filterItems: [FilterItem] = [
        FilterItem(image: .sort_by, text: "Sort by",filterType: .sortBy, isSelected: false),
        FilterItem(image: .ac, text: "AC",filterType: .ac, isSelected: false),
        FilterItem(image: .non_ac, text: "Non AC",filterType: .nonAC, isSelected: false),
        FilterItem(image: .single, text: "Single",filterType: .seater, isSelected: false),
        FilterItem(image: .sleeper, text: "Sleeper",filterType: .sleeper, isSelected: false)
    ]
   // var busViewModel = BusServiceViewModel()
    
    init() {

    }
    
    func performAction(for item: FilterItem,viewModel:BusServiceViewModel) {
        if let index = filterItems.firstIndex(where: { $0.id == item.id }) {
            filterItems[index].isSelected.toggle()
            
            let selectedFilters = filterItems.filter { $0.isSelected }
            
            if selectedFilters.count == 0 {
                viewModel.sortedBusServices = viewModel.busServices
            } else {
                for filter in selectedFilters {
                    
                    switch filter.image {
                    case .sort_by:
                        sortByTapped()
                    case .ac:
                        acTapped(vm:viewModel)
                    case .non_ac:
                        nonAcTapped(vm:viewModel)
                    case .single:
                        singleTapped(vm: viewModel)
                    case .sleeper:
                        sleeperTapped(vm: viewModel)
                    }
                }
            }
           
        }
    }
    
    func sortByTapped() {
        print("Sort by tapped")
        // Add your specific action code here
    }
    
    func acTapped(vm:BusServiceViewModel) {
        let acService = vm.busServices.filter { service in
            !service.busType.contains("NON-AC")
        }
        vm.sortedBusServices = acService
        print(acService)
    }
    
    func nonAcTapped(vm:BusServiceViewModel) {
        print("Non AC tapped")
        let nonACService = vm.busServices.filter { service in
            service.busType.contains("NON-AC")
        }
        vm.sortedBusServices = nonACService
        print(nonACService)
    }
    
    func singleTapped(vm:BusServiceViewModel) {
        print("Single tapped")
        let singleSeat = vm.busServices.filter { service in
            service.busType.contains("SEATER")
        }
        vm.sortedBusServices = singleSeat
        print(singleSeat)
    }
    
    func sleeperTapped(vm:BusServiceViewModel) {
        print("Sleeper tapped")
        let sleeper = vm.busServices.filter { service in
            service.busType.contains("SLEEPER")
        }
        vm.sortedBusServices = sleeper
        print(sleeper)
    }
    
   
    
 
}
