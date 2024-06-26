//
//  swiftUiExpApp.swift
//  swiftUiExp
//
//  Created by Shubam Vijay Yeme on 27/05/24.
//

import SwiftUI
import iOS_Common_Utilities

@main
struct swiftUiExpApp: App {

    var body: some Scene {
        WindowGroup {
//            BoardingAndDroppingListView(viewModel: BusServiceViewModel())
            CoordinatorView()
        }
    }
}
