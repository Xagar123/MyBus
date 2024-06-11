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
            
            if selectedFilters.isEmpty {
                viewModel.updateSortedBusServices(busServices: viewModel.busServices)
            } else {
                applySelectedFilters(viewModel: viewModel, selectedFilters: selectedFilters)
            }
           
        }
    }
    
    
    private func applySelectedFilters(viewModel: BusServiceViewModel, selectedFilters: [FilterItem]) {
        var filteredServices = Set<BusService>()
        var acSelected = false
        var nonAcSelected = false
        var singleSelected = false
        var sleeperSelected = false

        for filter in selectedFilters {
            switch filter.image {
            case .ac:
                acSelected = true
            case .non_ac:
                nonAcSelected = true
            case .single:
                singleSelected = true
            case .sleeper:
                sleeperSelected = true
            default:
                break
            }
        }

        var acNonAcServices = Set<BusService>()
        
        if acSelected {
            acNonAcServices.formUnion(viewModel.busServices.filter { $0.busType.contains("AC") && !$0.busType.contains("NON-AC") })
        }
        if nonAcSelected {
            acNonAcServices.formUnion(viewModel.busServices.filter { $0.busType.contains("NON-AC") })
        }
        
        if singleSelected || sleeperSelected {
            if acSelected || nonAcSelected {
                if singleSelected {
                    filteredServices.formUnion(acNonAcServices.filter { $0.busType.contains("SEATER") })
                }
                if sleeperSelected {
                    filteredServices.formUnion(acNonAcServices.filter { $0.busType.contains("SLEEPER") })
                }
            } else {
                if singleSelected {
                    filteredServices.formUnion(viewModel.busServices.filter { $0.busType.contains("SEATER") })
                }
                if sleeperSelected {
                    filteredServices.formUnion(viewModel.busServices.filter { $0.busType.contains("SLEEPER") })
                }
            }
        } else {
            filteredServices = acNonAcServices
        }
        
        print(viewModel.sortBySelected)
        viewModel.sortedBusServices = Array(filteredServices)
        viewModel.updateSortedBusServices(busServices: viewModel.sortedBusServices)
        print(filteredServices)
    }

}
