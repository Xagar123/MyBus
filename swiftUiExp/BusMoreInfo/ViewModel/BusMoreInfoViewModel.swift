import Foundation
import SwiftUI
import Combine

class BusMoreInfoViewModel: ObservableObject {
    @Published var busInfo: BusInfo?
    @Published var busSectionsList: [BusSectionList]?
    @Published var amenities: [BusAmenity] = []
    @Published var boardingPoints: BoardingDroppingHeaderPoints?
    @Published var refundPolicy: [BusRefundPolicy] = []
    @Published var travelPolicy: [BusMoreInfoTravelPolicy] = []
    @Published var selectedTab: String = "Amenities"
    @Published var isLoading: Bool = true
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.isLoading = true
        self.fetchBusInfo()
        self.fetchSectionsList()
        self.fetchAmenities()
        self.fetchBoardingPoints()
        self.fetchRefundPolicy()
        self.fetchTravelPolicy()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading = false
        }
    }
    
    func fetchBusInfo() {
        let dummyBusInfo = BusInfo(name: "Yolo Bus", type: "AC Sleeper (2+1)", rating: "4.8", reviews: "4400")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.busInfo = dummyBusInfo
        }
    }
    
    func fetchSectionsList() {
        let dummyAmenitiesBusInfo = BusSectionList(title: "Amenities", imageURL: "BusMoreInfoAmenities")
        let dummyStopsBusInfo = BusSectionList(title: "Stops", imageURL: "Location")
        let dummyRefundBusInfo = BusSectionList(title: "Refund", imageURL: "BusMoreInfoRefund")
        let dummyPolicyBusInfo = BusSectionList(title: "Policy", imageURL: "BusMoreInfoPolicy")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.busSectionsList = [dummyAmenitiesBusInfo, dummyStopsBusInfo, dummyRefundBusInfo, dummyPolicyBusInfo]
        }
    }
    
    func fetchAmenities() {
        let dummyAmenities = [
            BusAmenity(imageName: "person", title: "AC"),
            BusAmenity(imageName: "person", title: "Emergency Exit"),
            BusAmenity(imageName: "person", title: "Blankets"),
            BusAmenity(imageName: "person", title: "Reading Light"),
            BusAmenity(imageName: "person", title: "Charging Point"),
            BusAmenity(imageName: "person", title: "Water Bottle"),
            BusAmenity(imageName: "person", title: "Toilet"),
            BusAmenity(imageName: "person", title: "CCTV"),
            BusAmenity(imageName: "person", title: "GPS Tracking"),
            BusAmenity(imageName: "person", title: "Wi-Fi"),
            BusAmenity(imageName: "person", title: "Curtains"),
            BusAmenity(imageName: "person", title: "Pet Friendly"),
            BusAmenity(imageName: "person", title: "Wheel Chair"),
            BusAmenity(imageName: "person", title: "Reclining Seat"),
            BusAmenity(imageName: "person", title: "Luggage Storage"),
            BusAmenity(imageName: "person", title: "TV"),
            BusAmenity(imageName: "person", title: "Snacks"),
            BusAmenity(imageName: "person", title: "Hammer"),
            BusAmenity(imageName: "person", title: "Facial Tissue"),
            BusAmenity(imageName: "person", title: "Pillows"),
            BusAmenity(imageName: "person", title: "Chips"),
            BusAmenity(imageName: "person", title: "Fire Extinguisher"),
            BusAmenity(imageName: "person", title: "First Aid Box"),
            BusAmenity(imageName: "person", title: "Hand Sanitizer"),
            BusAmenity(imageName: "person", title: "Temperature Checks"),
            BusAmenity(imageName: "person", title: "Social Distancing"),
            BusAmenity(imageName: "person", title: "Fumigation"),
            BusAmenity(imageName: "person", title: "Driver/Conductor with Masks"),
            BusAmenity(imageName: "person", title: "Staff")
        ]
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.amenities = dummyAmenities
        }
    }
    
    func fetchBoardingPoints() {
        let dummyBoardingPoints = [
            BoardingDroppingPoint(time: "20:00", point: "Bellandur"),
            BoardingDroppingPoint(time: "21:00", point: "Bellandur"),
            BoardingDroppingPoint(time: "22:00", point: "Bellandur"),
            BoardingDroppingPoint(time: "23:00", point: "Bellandur")
        ]
        
        let dummyDroppingPoints = [
            BoardingDroppingPoint(time: "22:00", point: "Bellandur"),
            BoardingDroppingPoint(time: "21:00", point: "Bellandur"),
            BoardingDroppingPoint(time: "20:00", point: "Bellandur"),
            BoardingDroppingPoint(time: "18:00", point: "Bellandur")
        ]
        self.boardingPoints = BoardingDroppingHeaderPoints(boardingPointTitle: "Boarding Points", droppingPointTitle: "Dropping Points", boardingPoints: dummyBoardingPoints, droppingPoints: dummyDroppingPoints, selectedBoardingPoint: true)
    }
    
    func fetchRefundPolicy() {
        let dummyRefundPolicy = [
            BusRefundPolicy(cancellationTime: "Before 09-Aug 20:00", refundAmount: "₹1260", percentage: "(90%)"),
            BusRefundPolicy(cancellationTime: "Before 09-Aug 21:00 & 06-Sep 20:00", refundAmount: "₹1260", percentage: "(90%)"),
            BusRefundPolicy(cancellationTime: "Before 09-Aug 22:00", refundAmount: "₹1260", percentage: "(90%)"),
            BusRefundPolicy(cancellationTime: "Before 09-Aug 23:00 & 06-Sep 20:00", refundAmount: "₹1260", percentage: "(90%)"),
            BusRefundPolicy(cancellationTime: "Before 09-Aug 00:00", refundAmount: "₹1260", percentage: "(90%)"),
            BusRefundPolicy(cancellationTime: "Before 09-Aug 10:00 & 06-Sep 20:00", refundAmount: "₹1260", percentage: "(90%)"),
            BusRefundPolicy(cancellationTime: "Before 09-Aug 12:00", refundAmount: "₹1260", percentage: "(90%)"),
            BusRefundPolicy(cancellationTime: "Before 09-Aug 13:00 & 06-Sep 20:00", refundAmount: "₹1260", percentage: "(90%)")
        ]
        self.refundPolicy = dummyRefundPolicy
    }
    
    func fetchTravelPolicy() {
        let travelPolicy = [BusMoreInfoTravelPolicy(image: "", title: "Do need to buy a ticket for my child?", subTitle: "please purchase a ticket for children above the age of 6"),
                            BusMoreInfoTravelPolicy(image: "", title: "Will be charged for excess luggage?", subTitle: "Yes , excess luggage is chargeable. You are allowed to carry 2 pieces of luggage, 15 Kgs each. Allowing luggage packed in carton boxes is at the discretion of the bus partner."),
                            BusMoreInfoTravelPolicy(image: "", title: "Can travel with my Pet?", subTitle: "Travelling with your pets in the bus is not permitted."),
                            BusMoreInfoTravelPolicy(image: "", title: "Is there any Alcohol/liquor policy?", subTitle: "Yes. Alcohol/liguor consumption and Carrying it inside the bus is prohibited."),
                            BusMoreInfoTravelPolicy(image: "", title: "Will the bus wait if the boarding time has passed?", subTitle: "Bus partner do not wait for the passengers beyond the departure time. There is no refund policy if the passenger missed the bus for arriving late at the boarding point.")]
        self.travelPolicy = travelPolicy
    }
}

struct BusInfo: Codable {
    let name: String
    let type: String
    let rating: String
    let reviews: String
}

struct BusSectionList: Codable, Hashable {
    let title: String
    let imageURL: String
}

struct BusAmenity: Codable {
    let imageName: String
    let title: String
}

struct BoardingDroppingHeaderPoints: Codable, Hashable {
    var boardingPointTitle: String
    var droppingPointTitle: String
    var boardingPoints: [BoardingDroppingPoint]
    var droppingPoints: [BoardingDroppingPoint]
    var selectedBoardingPoint: Bool
}

struct BoardingDroppingPoint: Codable, Hashable {
    let time: String
    let point: String
}

struct BusRefundPolicy: Codable, Hashable {
    let cancellationTime: String
    let refundAmount: String
    let percentage: String
}
