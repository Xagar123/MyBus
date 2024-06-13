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
    var selectedBusIndex : Int = 10
    @Published var pickupPointList = [PickupLocation(time: "", location: "", fullAddress: "")]
    @Published var dropPointList = [PickupLocation(time: "", location: "", fullAddress: "")]
    var copyPickupPointList = [PickupLocation(time: "", location: "", fullAddress: "")]
    var copyDropPointList = [PickupLocation(time: "", location: "", fullAddress: "")]
    init() {
            availableBusService(source: 3, destination: 5, date: "2024-06-13")
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
                let response = try decoder.decode(BusServiceResponse.self, from: data)
                let busList = response.services
             //   print(busList)
                //parsePickupLocations(from: busList[9].boardingInfo)
//              pickupPointList =
                DispatchQueue.main.async {
                    self.busServices = busList
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
   
}
