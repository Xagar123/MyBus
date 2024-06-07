//
//  Model.swift
//  POC2
//
//  Created by Sagar on 05/06/24.
//

import Foundation

struct BusServiceResponse: Codable {
    let status: String
    let services: [BusService]
}

struct BusService: Codable,Identifiable, Hashable {
    let id = UUID()
    let operatorID, serviceKey, serviceName, serviceNumber: String
        var travelerAgentName, busTypeName, startTime, arrTime: String
        var travelTime: String
        var sourceID, destinationID, fare: Int
        var availableSeats, jdate, busStartDate: String
        var layoutID: Int
        var amenities: String?
        var boardingInfo, droppingInfo: [String]
        var cancellationpolicy, busType, isBordDropFirst, isSingleLady: String

        enum CodingKeys: String, CodingKey {
            case operatorID = "operatorId"
            case serviceKey = "Service_key"
            case serviceName = "Service_Name"
            case serviceNumber = "Service_Number"
            case travelerAgentName = "Traveler_Agent_Name"
            case busTypeName = "Bus_Type_Name"
            case startTime = "Start_time"
            case arrTime = "Arr_Time"
            case travelTime = "TravelTime"
            case sourceID = "Source_ID"
            case destinationID = "Destination_ID"
            case fare = "Fare"
            case availableSeats = "available_seats"
            case jdate
            case busStartDate = "BUS_START_DATE"
            case layoutID = "layout_id"
            case amenities = "Amenities"
            case boardingInfo = "boarding_info"
            case droppingInfo = "dropping_info"
            case cancellationpolicy = "Cancellationpolicy"
            case busType = "bus_type"
            case isBordDropFirst, isSingleLady
        }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.operatorID = try container.decode(String.self, forKey: .operatorID)
        self.serviceKey = try container.decode(String.self, forKey: .serviceKey)
        self.serviceName = try container.decode(String.self, forKey: .serviceName)
        self.serviceNumber = try container.decode(String.self, forKey: .serviceNumber)
        self.travelerAgentName = try container.decode(String.self, forKey: .travelerAgentName)
        self.busTypeName = try container.decode(String.self, forKey: .busTypeName)
        self.startTime = try container.decode(String.self, forKey: .startTime)
        self.arrTime = try container.decode(String.self, forKey: .arrTime)
        self.travelTime = try container.decodeIfPresent(String.self, forKey: .travelTime) ?? ""
        self.sourceID = try container.decode(Int.self, forKey: .sourceID)
        self.destinationID = try container.decode(Int.self, forKey: .destinationID)
        self.fare = try container.decode(Int.self, forKey: .fare)
        self.availableSeats = try container.decode(String.self, forKey: .availableSeats)
        self.jdate = try container.decode(String.self, forKey: .jdate)
        self.busStartDate = try container.decode(String.self, forKey: .busStartDate)
        self.layoutID = try container.decode(Int.self, forKey: .layoutID)
        self.amenities = try container.decodeIfPresent(String.self, forKey: .amenities)
        self.boardingInfo = try container.decode([String].self, forKey: .boardingInfo)
        self.droppingInfo = try container.decode([String].self, forKey: .droppingInfo)
        self.cancellationpolicy = try container.decode(String.self, forKey: .cancellationpolicy)
        self.busType = try container.decode(String.self, forKey: .busType)
        self.isBordDropFirst = try container.decode(String.self, forKey: .isBordDropFirst)
        self.isSingleLady = try container.decode(String.self, forKey: .isSingleLady)
    }
    
   
}



struct DroppingInfo: Codable {
    let info: String
    let destination: String
}

