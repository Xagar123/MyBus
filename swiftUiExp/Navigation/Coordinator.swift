//
//  Coordinator.swift
//  swiftUiExp
//
//  Created by Sagar on 17/06/24.
//

import SwiftUI

enum Screens: String, Identifiable {
    case filterFullScreen, SearchResultBusList, boardingAndDropingView,busPartner
    
    var id:String {
        self.rawValue
    }
}

enum Sheet: String, Identifiable {
    case filterScreen
    
    var id: String {
        self.rawValue
    }
}

enum FullScreens: String, Identifiable {
    case filterFullScreen, busPartner, boardingPoint, dropingPoint
    
    var id: String {
        self.rawValue
    }
}

class Coordinator: ObservableObject {
    
    @Published var navigationPath = NavigationPath()
    @Published var currentSheet: Sheet?
    @Published var currentFullScreen: FullScreens?
    
    // MARK: - Navigation Methods
    
    /// Adds a screen to the navigation path
    func navigateToScreen(_ screen: Screens) {
        self.navigationPath.append(screen)
    }
    
    /// Presents a sheet
    func presentSheet(_ sheet: Sheet) {
        self.currentSheet = sheet
    }
    
    /// Presents a full screen
    func presentFullScreen(_ fullScreen: FullScreens) {
        self.currentFullScreen = fullScreen
    }
    
    /// Removes the last screen from the navigation path
    func pop(delay: Double = 0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            withAnimation {
                if !self.navigationPath.isEmpty {
                    self.navigationPath.removeLast()
                }
            }
        }
       
    }
    
    /// Removes all screens from the navigation path, returning to the root
    func popToRoot() {
        withAnimation {
            self.navigationPath.removeLast(self.navigationPath.count)
        }
        
    }
    
    /// Dismisses the current sheet
    func dismissSheet() {
        self.currentSheet = nil
    }
    
    /// Dismisses the current full screen
    func dismissFullScreen() {
        self.currentFullScreen = nil
    }
    
    // MARK: - View Building
    
    @ViewBuilder
    func buildView(screen: Screens) -> some View {
        switch screen {
        case .filterFullScreen:
            FilterFullScreen()
        case .SearchResultBusList:
            SearchResultBusList()
        case .boardingAndDropingView:
            BoardingAndDroppingListView(viewModel: BusServiceViewModel())
        case .busPartner:
            CommonFiltersInsightsView(preferredBusPartner: [], placeholderText: "Search destination", pageType: .preferredBusPartner)
        }
    }
    
    @ViewBuilder
    func buildView(sheet: Sheet) -> some View {
        switch sheet {
        case .filterScreen:
            FilterFullScreen()
        }
    }
    
    @ViewBuilder
    func buildView(fullScreen: FullScreens) -> some View {
        switch fullScreen {
        case .filterFullScreen:
            FilterFullScreen()
        case .busPartner:
            CommonFiltersInsightsView(preferredBusPartner: [], placeholderText: "Search destination", pageType: .preferredBusPartner)
        case .boardingPoint:
            CommonFiltersInsightsView(preferredBusPartner: [], placeholderText: "Search location", pageType: .preferredBusPartner)
        case .dropingPoint:
            CommonFiltersInsightsView(preferredBusPartner: [], placeholderText: "Search destination", pageType: .preferredBusPartner)
        }
    }
}
