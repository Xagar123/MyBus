import Foundation
enum ScreenType : String {
    case preferredBusPartner = "Preferred Bus Partner"
    case PreferredPickupPoint = "Preferred pickup point"
    case PreferredDroppingPoint = "Preferred dropping point"
}
struct preferredBus : Codable,Identifiable{
   
    var id :  UUID?
    var status : String
    var operatorsInfo : [Operators]
    init(id: UUID? = nil, status: String, operatorsInfo: [Operators]) {
        self.id = id
        self.status = status
        self.operatorsInfo = operatorsInfo
    }
    
}

struct Operators : Codable , Identifiable,Hashable{
    var id: UUID? = UUID()
    var  operator_id : String
    var operater_name : String
    var partialCancellation : String
    var isSelected : Bool? = false
    init(id: UUID? = nil, operator_id: String, operater_name: String, partialCancellation: String) {
        self.id = id
        self.operator_id = operator_id
        self.operater_name = operater_name
        self.partialCancellation = partialCancellation
    }
}
