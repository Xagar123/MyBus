//
//  DroppingAndBoardingModel.swift
//  swiftUiExp
//
//  Created by Shubam Vijay Yeme on 11/06/24.
//

import Foundation

struct PickupLocation: Identifiable {
    var id = UUID()
    var time: String
    var location: String
    var fullAddress: String
}
struct BoardingDroppingLocation : Identifiable,Hashable{
    var id = UUID()
    var location : String
}
