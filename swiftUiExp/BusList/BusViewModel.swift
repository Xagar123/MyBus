//
//  BusViewModel.swift
//  POC2
//
//  Created by Sagar on 05/06/24.
//

import Foundation

class BusServiceViewModel: ObservableObject {
    
    @Published var busServices: [BusService] = []
    @Published var filterBusList: [BusService] = []
    @Published var errorMessage: String?
    @Published var hasFetchedData = false
    var selectedBusIndex : Int = 1
    @Published var pickupPointList = [PickupLocation(time: "", location: "", fullAddress: "")]
    @Published var dropPointList = [PickupLocation(time: "", location: "", fullAddress: "")]
    var copyPickupPointList = [PickupLocation(time: "", location: "", fullAddress: "")]
    var copyDropPointList = [PickupLocation(time: "", location: "", fullAddress: "")]
    @Published var sortBySelected: SortBy = .all {
        didSet {
            updateSortedBusServices(busServices: busServices)
        }
    }
    @Published var sortedBusServices: [BusService] = []
    
    init() {
            availableBusService(source: 3, destination: 5, date: "2024-06-26")
    }

    func availableBusService(source: Int, destination: Int, date: String) {
       
        let urlString = "https://api.mynpro.xyz/bus/user/api/abhibus/available-services"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "source": source,
            "destination": destination,
            "date": date
        ]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            print("Error encoding parameters: \(error)")
            return
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }
            do {
                let decoder = JSONDecoder()
                print(try? JSONSerialization.jsonObject(with: data))
                let response = try decoder.decode(BusServiceResponse.self, from: data)
                let busList = response.services
             //   print(busList)
                //parsePickupLocations(from: busList[9].boardingInfo)
//              pickupPointList =
                DispatchQueue.main.async {
                    self.busServices = busList
                    self.sortedBusServices = busList
                    self.hasFetchedData = true
                }
            } catch {
                print("Error parsing JSON: \(error)")
                DispatchQueue.main.async {
                    self.errorMessage = "Error parsing JSON: \(error.localizedDescription)"
                }
            }
        }
        task.resume()
    }
    
    
    func filterPickupAndDropLocation(with searchText: String, onFirstPage: Bool ) {
        if searchText == "" {
            self.pickupPointList = self.copyPickupPointList
            self.dropPointList = self.copyDropPointList
            return
        }
        if onFirstPage {
            self.pickupPointList = self.copyPickupPointList.filter { pickUpLocation in
                if pickUpLocation.location.lowercased().contains(searchText.lowercased()) {
                    return true
                }
                return false
            }
            
        } else {
            self.dropPointList = self.copyDropPointList.filter { pickUpLocation in
                if pickUpLocation.location.lowercased().contains(searchText.lowercased()) {
                    return true
                }
                return false
            }
        }
    }
    //MARK: - Sortby
    
   
    func updateSortedBusServices(busServices: [BusService]) {
            switch sortBySelected {
            case .all:
                sortedBusServices = busServices
            case .topRated:
                sortedBusServices = busServices
            case .priceCheapest:
                sortedBusServices = busServices.sorted { $0.fare < $1.fare }
            case .priceExpensive:
                sortedBusServices = busServices.sorted { $0.fare > $1.fare }
            case .availabilityLowtoHigh:
                sortedBusServices = busServices.sorted {
                    if let seats0 = Int($0.availableSeats), let seats1 = Int($1.availableSeats) {
                        return seats0 < seats1
                    } else {
                        if Int($0.availableSeats) == nil && Int($1.availableSeats) == nil {
                            return false
                        }
                        return Int($0.availableSeats) != nil
                    }
                }
            case .availabilityHightoLow:
                sortedBusServices = busServices.sorted {
                    if let seats0 = Int($0.availableSeats), let seats1 = Int($1.availableSeats) {
                        return seats0 > seats1
                    } else {
                        if Int($0.availableSeats) == nil && Int($1.availableSeats) == nil {
                            return false
                        }
                        return Int($0.availableSeats) != nil
                    }
                }
            case .departureEarly:
                sortedBusServices = busServices.sorted { self.convertTo24HourFormat(time: $0.startTime)! < self.convertTo24HourFormat(time: $1.startTime)!}
            case .departureLate:
                sortedBusServices = busServices.sorted { self.convertTo24HourFormat(time: $0.startTime)! > self.convertTo24HourFormat(time: $1.startTime)!}
            }
        }
    
    
    //MARK: - Date formater
    
    func convertTo24HourFormat(time: String) -> String? {
        
        let inputFormat = DateFormatter()
        inputFormat.dateFormat = "h:mm a"
        inputFormat.locale = Locale(identifier: "en_US_POSIX")
        
        let outputFormat = DateFormatter()
        outputFormat.dateFormat = "HH:mm"
        outputFormat.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = inputFormat.date(from: time) {
            return outputFormat.string(from: date)
        } else {
            print("Invalid input time format")
            return nil
        }
    }
    
    
    func convertDurationToReadableFormat(duration: String) -> String? {
        
        /// from api we are getting in this format  -> "TravelTime": "05:00:00", and converting into ->10 hrs 04 mins
        let components = duration.split(separator: ":")
        
        /// there are 3 components (hours, minutes, seconds)
        guard components.count == 3,
              let hours = Int(components[0]),
              let minutes = Int(components[1]) else {
            print("Invalid input duration format")
            return nil
        }
        
        let readableFormat: String
        
        if hours > 0 {
            readableFormat = "\(hours) hrs \(minutes) mins"
        } else {
            readableFormat = "\(minutes) mins"
        }
        
        return readableFormat
    }
   
}
