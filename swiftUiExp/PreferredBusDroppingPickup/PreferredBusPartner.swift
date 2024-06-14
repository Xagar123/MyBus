import SwiftUI
import Combine
enum ScreenType : String {
    case preferredBusPartner = "Preferred Bus Partner"
    case PreferredPickupPoint = "PreferredPickupPoint"
    case PreferredDroppingPoint = "PreferredDroppingPoint"
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
struct PreferredDropping : Codable,Identifiable {
    var id : UUID? = UUID()
    var status : String
    var services : [Services]
}
struct Services : Codable, Identifiable, Hashable{
    var id: UUID? = UUID()
    var operatorId : String
    var Service_key : String
    var Service_Name : String
    var Service_Number : String
    var Traveler_Agent_Name  : String
    var Bus_Type_Name : String
    var Start_time : String
    var Arr_Time : String
    var TravelTime : String?
    var Source_ID : Int
    var Destination_ID : Int
    var Fare : Int
    var available_seats : String
    var jdate : String
    var BUS_START_DATE : String
    var layout_id : Int?
    var Amenities : String?
    var boarding_info : [String]
    var dropping_info : [String]
    var Cancellationpolicy : String
    var bus_type : String
    var isBordDropFirst : String
    var isSingleLady : String
    var allowedConcessions : [String]?
}
struct RefundPolicies: Codable ,Identifiable{
    var id: UUID? = UUID()
    
    var status : String
    var Cancellationpy : Cancellation
    
}
struct Cancellation : Codable,Identifiable {
  var id: UUID? = UUID()
   var  operatorId : String
   var  Service_key : String
   var  Service_Name : String
   var  Traveler_Agent_Name : String
    var arrboarding_info : String
    var Cancellationpy : isCancellables
}
struct isCancellables : Codable, Identifiable{
    var id: UUID? = UUID()
    
    var  isCancellable : String
    var conditions : [Results]
    
}
struct Results: Codable , Identifiable{
    var id: UUID? = UUID()
    var rp : String
    var cc : String
    var tl : String
}


struct PreferredBusPartner: View {
    @State private var isPresentingPreferredBusPartner = false
    @State private var isPresentingBoardingPoint = false
    @State private var isPresentingDroppingPoint = false
    @StateObject var viewModel = PreferredBusPartnerViewModel()
    @State var preferredBusPartner  = []
    var placeholderText : String
    @State var selectedItems  =  [Operators]()
    @State var servicesSelectedItem = [Services]()
    var pageType : ScreenType
    @StateObject var busViewModel = BusServiceViewModel()
    var body: some View {
        NavigationView{
            
            VStack{
                HStack{
                    Button(action: {
                        
                    }) {
                        Image("Chevron_right")
                    }
                    //                    .padding(.trailing)
                    Text(pageType.rawValue)
                        .fontWeight(.bold)
                        .font(.custom("Metropolis", size: 20))
                }
                .frame(width: 360,height: 60)
                .padding(.trailing,150)
                
                Color.gray.frame(height: 1 / UIScreen.main.scale)
                    .padding(.bottom,8)
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(hex:"#D9D9D9"))
                    
                        .padding(.leading,10)
                    
                    TextField(placeholderText, text: $viewModel.PreferredBusPartnerSearchText
                    )
                    .foregroundColor(.white)
                    
                    .onAppear(perform: {
                        viewModel.searchEnable(pageType: pageType)
                    })
                    if !viewModel.PreferredBusPartnerSearchText.isEmpty {
                        Button("", systemImage: "multiply") {
                            viewModel.PreferredBusPartnerSearchText = ""
                            
                        }
                        .foregroundColor(.white)
                    }
                }
                
                .frame(width: 328,height: 56)
                .padding(.all,5)
                .background(Color(hex:"#181818"))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 1)
                )
                
                VStack()
                {
                    switch pageType {
                    case .preferredBusPartner:
                        
                        if let searchResult = viewModel.preferredBusPartnerSearchResult {
                            CreateListView(listData: searchResult, selectedItems: $selectedItems)
                        } else {
                            PreferredBusPartnerView(viewModel: viewModel, selectedItems: $selectedItems)
                        }
                        
                    case .PreferredDroppingPoint:
                        if let searchResult = viewModel.preferredDroppingPickUPPointSearchResult {
                            PreferredDroppingAndPickUpPointView(preferredDroppingAndPickUpPointListData: searchResult, selectedItems: $servicesSelectedItem)
//                        if let searchResult = busViewModel.filterBusList {
//                            PreferredDroppingAndPickUpPointView(preferredDroppingAndPickUpPointListData : searchResult, selectedItems: <#T##Binding<[Services]>#>)
                            
                        } else {
                            PreferredDroppingAndPickUpPointView(preferredDroppingAndPickUpPointListData: viewModel.fetchDroppingAndPickUpPoint, selectedItems: $servicesSelectedItem)
                        }
                    case .PreferredPickupPoint :
                        if let searchResult = viewModel.preferredDroppingPickUPPointSearchResult {
                            PreferredDroppingAndPickUpPointView(preferredDroppingAndPickUpPointListData: searchResult, selectedItems: $servicesSelectedItem)
                        } else {
                            PreferredDroppingAndPickUpPointView(preferredDroppingAndPickUpPointListData: viewModel.fetchDroppingAndPickUpPoint, selectedItems: $servicesSelectedItem)
                        }
                    }
                }
                
                
                
                Color.gray.frame(height: 1 / UIScreen.main.scale)
                    .padding(.bottom,10)
                Button("Continue") {
                    if pageType == .preferredBusPartner {
                        isPresentingBoardingPoint = true
                        
                    }
                    else if pageType == .PreferredPickupPoint {
                        isPresentingBoardingPoint = true
                        
                    }
                    else if pageType == .PreferredDroppingPoint{
                        isPresentingDroppingPoint = true
                    }
                    else {
                        
                    }
                }
                .fullScreenCover(isPresented: $isPresentingBoardingPoint) {
                    PreferredBusPartner(placeholderText: "Preferred PickUpPoint", pageType: .PreferredPickupPoint)
                }
                .fullScreenCover(isPresented: $isPresentingDroppingPoint) {
                    PreferredBusPartner(placeholderText: "Preferred PickUpPoint", pageType: .PreferredDroppingPoint)
                }
                .frame(width: 328,height: 48,alignment: .center)
                .background(Color.white)
                .cornerRadius(8)
                .foregroundColor(.black)
                .fontWeight(.bold)
            }
            .onAppear {
                viewModel.pageType = pageType
                viewModel.fetchData()
            }
        }
    }
}
    


#Preview {
    PreferredBusPartner(placeholderText: "preffered location", pageType: .PreferredPickupPoint)
}



struct PreferredBusPartnerView : View {
@ObservedObject var viewModel : PreferredBusPartnerViewModel
   
    @Binding var selectedItems:  [Operators]
    var body: some View {
        CreateListView(listData: viewModel.fetchBusPartner, selectedItems: $selectedItems)
    }
}

struct CreateListView : View {
    var listData: [Operators]
    @Binding var selectedItems: [Operators]
    var body: some View {
        @StateObject var viewModel = PreferredBusPartnerViewModel()
        List(listData, id: \.operator_id) { item in
           
            VStack(){
                HStack{
                    Text("\(item.operater_name)")
                    Spacer()
                    Image(systemName: selectedItems.contains(where: { element in
                        if element.operator_id == item.operator_id {
                            return true
                        } else {
                            return false
                        }
                        
                    })  ? "checkmark.square.fill" : "square")
                }
            }
            
            .padding(.vertical,10)
            .onTapGesture {
                if selectedItems.contains(item) {
                    selectedItems.removeAll { operators in
                        if operators == item {
                            return true
                        }
                        return false
                    }
                } else {
                    selectedItems.append(item)
                    
                }
            }
        }.listStyle(.plain)
    }
}


struct PreferredDroppingAndPickUpPointView: View {
    var preferredDroppingAndPickUpPointListData: [Services]
    @Binding var selectedItems:  [Services]
    @State var processedDroppingInfo = []
    @State var processedBoardingInfo : [String] = []
    
    var body: some View {
        List(preferredDroppingAndPickUpPointListData, id: \.operatorId) { item in
                   VStack(alignment: .leading,spacing: 20) {
                       ForEach(filterDroppingInfo(item.dropping_info), id: \.self) { filteredInfo in
                           HStack{
                               Text(filteredInfo)
                               Spacer()
                               Image(systemName: selectedItems.contains(item) ? "checkmark.square.fill" : "square")
                           }
                       }
                        
                    }
                
                .padding(.vertical,10)
                .onTapGesture {
                    print("tapped")
                    if selectedItems.contains(item) {
                        selectedItems.removeAll { service in
                            if service == item {
                                return true
                            }
                            return false
                        }
                    } else {
                        selectedItems.append(item)
                        
                    }
                }
            }
            .listStyle(.plain)
            
        }
    }
    
    private func filterDroppingInfo(_ infos: [String]) -> [String] {
        return infos.map { info in
            let components = info.split(separator: "^")
            return components.count > 1 ? String(components[1]) : ""
        }
    }
struct PreferredPickupPointView : View {
    @State var PreferredPickupPointViewListData: [Services]
    @Binding var selectedItems:  [Services]
    @State var processedPickupInfo = []
    @State var processedBoardingInfo : [String] = []
    
    var body: some View {
        List(PreferredPickupPointViewListData, id: \.operatorId) { item in
                   VStack(alignment: .leading,spacing: 20) {
                       ForEach(item.boarding_info,id: \.self)
                       { filteredInfo in
                           HStack{
                               Text(filteredInfo)
                               Spacer()
                               Image(systemName: selectedItems.contains(where: { element in
                                   if element.operatorId == item.operatorId {
                                       processedPickupInfo.append(item.dropping_info)
                                       return true
                                   } else {
                                       return false
                                   }
                                   
                               })  ? "checkmark.square.fill" : "square")
                           }
                       }
                        
                    }
                
                .padding(.vertical,10)
                .onTapGesture {
                    selectedItems.append(item)
                }
            }
            .listStyle(.plain)
            
        }
    }
    
  
    

    

