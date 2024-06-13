//
//  Model.swift
//  swiftUiExp
//
//  Created by Sagar on 07/06/24.
//

import Foundation


struct FilterItem: Identifiable {
    let id = UUID()
    let image: FilterImage
    let text: String
    let filterType: FilterType
    var isSelected: Bool = false
}

enum FilterType {
    case sortBy
    case ac
    case nonAC
    case seater
    case sleeper 
}
