//
//  Coordinator.swift
//  swiftUiExp
//
//  Created by Sagar on 06/06/24.
//

import Foundation

class Coordinator: ObservableObject {
    
    @Published var path:[Route] = []
    
    enum Route: Hashable {
        case FilterView
    }
    
    func navigate(to route:Route) {
        path.append(route)
    }
    
    func navigateBack() {
        path.removeLast()
    }
    
    func navigateToRoot() {
        path.removeAll()
    }
    
    func navigateBackTo(_ route: Route) {
        while path.last != route {
            path.removeLast()
        }
    }
}
