//
//  HorizontalFilterViewModel.swift
//  swiftUiExp
//
//  Created by Sagar on 07/06/24.
//

import Foundation

class FilterViewModel: ObservableObject {
    
    @Published var filterItems: [FilterItem]
    var busViewModel = BusServiceViewModel()
    
    init() {
        self.filterItems = [
            FilterItem(image: .sort_by, text: "Sort by",filterType: .sortBy),
            FilterItem(image: .ac, text: "AC",filterType: .ac),
            FilterItem(image: .non_ac, text: "Non AC",filterType: .nonAC),
            FilterItem(image: .single, text: "Single",filterType: .seater),
            FilterItem(image: .sleeper, text: "Sleeper",filterType: .sleeper)
        ]
    }
    
    func performAction(for item: FilterItem) {
        if let index = filterItems.firstIndex(where: { $0.id == item.id }) {
            filterItems[index].isSelected.toggle()
            
            switch item.image {
            case .sort_by:
                sortByTapped()
            case .ac:
                acTapped()
            case .non_ac:
                nonAcTapped()
            case .single:
                singleTapped()
            case .sleeper:
                sleeperTapped()
            }
        }
    }
    
    func sortByTapped() {
        print("Sort by tapped")
        // Add your specific action code here
    }
    
    func acTapped() {
        print("AC tapped")
        // Add your specific action code here
    }
    
    func nonAcTapped() {
        print("Non AC tapped")
        // Add your specific action code here
    }
    
    func singleTapped() {
        print("Single tapped")
        // Add your specific action code here
    }
    
    func sleeperTapped() {
        print("Sleeper tapped")
        // Add your specific action code here
    }
    
//    func updateFileredBusService() {
//        
//        var filteredServices: [BusService] = []
//        
//        for service in busViewModel.busServices {
//            
//            var shouldIncludeService = true
//            
//            for filterItem in filterItems {
//                if filterItem.isSelected && !service.matchesFilterCriteria(filterItem) {
//                    
//                }
//            }
//        }
//        
//    }
 
}
