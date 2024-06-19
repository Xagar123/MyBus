//
//  swiftUiExpApp.swift
//  swiftUiExp
//
//  Created by Shubam Vijay Yeme on 27/05/24.
//

import SwiftUI

@main
struct swiftUiExpApp: App {

    var body: some Scene {
        WindowGroup {
//            BoardingAndDroppingListView(viewModel: BusServiceViewModel())
            CoordinatorView()
        }
    }
}
