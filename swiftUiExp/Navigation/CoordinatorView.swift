//
//  CoordinatorView.swift
//  swiftUiExp
//
//  Created by Sagar on 06/06/24.
//

import Foundation
import SwiftUI

struct CoordinatorView<Content: View>: View {
    
    @StateObject private var coordinator = Coordinator()
    let content: Content
    
    init(@ViewBuilder content: () -> Content ) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            content
                .environmentObject(coordinator)
                .navigationDestination(for: Coordinator.Route.self) { route in
                    
                    switch route {
                        
                    case .FilterView:
                        FilterFullScreen().environmentObject(coordinator)
                    }
                }
        }
    }
}
