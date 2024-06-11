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
    var isSelected: Bool 
}

enum FilterType {
    case sortBy
    case ac
    case nonAC
    case seater
    case sleeper 
}

enum SortBy: String {
    case all = "All"
    case topRated = "Top rated"
    case priceCheapest = "Price: Cheapest"
    case priceExpensive = "Price: Expensive"
    case availabilityLowtoHigh = "Availability: Low to High"
    case availabilityHightoLow = "Availability: High to Low"
    case departureEarly = "Departure: Early"
    case departureLate = "Departure: Late"
}



enum FilterImage: String {
    case sort_by = "expand_all"
    case ac = "ac"
    case non_ac = "non_ac"
    case single = "chair"
    case sleeper = "Sleeper"
}
