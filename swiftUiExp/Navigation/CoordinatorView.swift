//
//  CoordinatorView.swift
//  swiftUiExp
//
//  Created by Sagar on 17/06/24.
//

import SwiftUI

struct CoordinatorView: View {
    
    @StateObject private var coordinator = Coordinator()
    @StateObject private var busVM = BusServiceViewModel()
    var body: some View {
       
        NavigationStack(path: $coordinator.navigationPath) {
            //configuring the initial view
            coordinator.buildView(screen: .BusHomePageTabBar)
            //for navigation using push
                .navigationDestination(for: Screens.self) { screens in
                    coordinator.buildView(screen: screens)
                }
            // for presenting sheet
                .sheet(item: $coordinator.currentSheet) { sheet in
                    coordinator.buildView(sheet: sheet)
                }
            // for presenting FullScreen
                .fullScreenCover(item: $coordinator.currentFullScreen) { fullScreen in
                    coordinator.buildView(fullScreen: fullScreen)
                }
        }
        .environmentObject(coordinator)
        .environmentObject(busVM)
    }
}

#Preview {
    CoordinatorView()
}
