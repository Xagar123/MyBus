//
//  BoardingAndDroppingViewModel.swift
//  swiftUiExp
//
//  Created by Shubam Vijay Yeme on 11/06/24.
//

import Foundation


func parsePickupLocations(from data: [String]) -> [PickupLocation] {
    var locations: [PickupLocation] = []
    
    for item in data {
        // Split the string by "^"
        let components = item.split(separator: "^")
        
        // Check if there are enough components to extract data
        if components.count >= 3 {
            let location = String(components[0]).trimmingCharacters(in: .whitespacesAndNewlines)
            let time = String(components[1]).trimmingCharacters(in: .whitespacesAndNewlines)
            // Convert the time to 24-hour format
            let time24Hour = convertTo24HourFormat(time: time)
            // Join the rest of the components for the full address
            let fullAddressWithPrefix = components.dropFirst(2).joined(separator: " ").trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Remove any numeric prefix using a regular expression
            let cleanedFullAddress = removeNumericPrefix(from: fullAddressWithPrefix)
            
            // Append the new PickupLocation to the array
            locations.append(PickupLocation(time: time24Hour, location: location, fullAddress: cleanedFullAddress))
        }
    }
    
    return locations
}

func parseDropLocation(from data: [String]) -> [PickupLocation] {
    var locations: [PickupLocation] = []
    
    for item in data {
        // Split the string by "^"
        let components = item.split(separator: "^")
        
        // Check if there are enough components to extract data
        if components.count >= 3 {
            let time = String(components[2]).trimmingCharacters(in: .whitespacesAndNewlines)
            let location = String(components[1]).trimmingCharacters(in: .whitespacesAndNewlines)
            // Convert the time to 24-hour format
            let time24Hour = convertTo24HourFormat(time: time)
            // Join the rest of the components for the full address
            let fullAddressWithPrefix = components.dropFirst(3).joined(separator: " ").trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Remove any numeric prefix using a regular expression
            let cleanedFullAddress = removeNumericPrefix(from: fullAddressWithPrefix)
            
            // Append the new PickupLocation to the array
            locations.append(PickupLocation(time: time24Hour, location: location, fullAddress: cleanedFullAddress))
        }
    }
    
    return locations
}
func removeNumericPrefix(from address: String) -> String {
    // Regular expression to match and remove numeric prefixes
    let pattern = "^[0-9]+\\s*"
    if let regex = try? NSRegularExpression(pattern: pattern) {
        let range = NSRange(location: 0, length: address.utf16.count)
        let cleanedAddress = regex.stringByReplacingMatches(in: address, options: [], range: range, withTemplate: "")
        return cleanedAddress.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    return address
}


func convertTo24HourFormat(time: String) -> String {
    // Define date formatters
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "hh:mm a"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    
    let time24HourFormatter = DateFormatter()
    time24HourFormatter.dateFormat = "HH:mm"
    time24HourFormatter.locale = Locale(identifier: "en_US_POSIX")
    
    // Parse the input time
    if let date = dateFormatter.date(from: time) {
        // Format to 24-hour time
        return time24HourFormatter.string(from: date)
    }
    
    // Return the original time if parsing fails
    return time
}
