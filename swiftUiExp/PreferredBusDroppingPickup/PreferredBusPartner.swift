import SwiftUI
import Combine
enum ScreenType : String {
    case preferredBusPartner = "Preferred Bus Partner"
    case PreferredPickupPoint = "Preferred Boarding Point"
    case PreferredDroppingPoint = "Preferred Dropping Point"
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

struct PreferredBusPartner: View {
    @Environment(\.dismiss) var dismiss
    @State private var isPresentingPreferredBusPartner = false
    @State private var isPresentingBoardingPoint = false
    @State private var isPresentingDroppingPoint = false
    @StateObject var viewModel = PreferredBusPartnerViewModel()
    @State var preferredBusPartner  = []
    var placeholderText : String
    @State var selectedItems  =  [Operators]()
    @State var servicesSelectedItem = [BusService]()
    var pageType : ScreenType
    @ObservedObject var busViewModel = BusServiceViewModel()
    
    
    var body: some View {
        NavigationView{
            
            VStack{
                HStack{
                    Button(action: {
                        dismiss()
                    }) {
                        Image("Chevron_right")
                    }
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
                        
                    case .PreferredPickupPoint:
                        if let searchResult = viewModel.preferredDroppingPickUPPointSearchResult{
                            PreferredBoardingPointView(listData: searchResult, selectedItems: $servicesSelectedItem, viewModel: self.busViewModel)
                        } else {
                            PreferredDroppingBoardingView(viewModel: self.busViewModel, selectedItems: $servicesSelectedItem)
                          
                        }
                    case .PreferredDroppingPoint :
                        if (viewModel.preferredDroppingPickUPPointSearchResult != nil) {
                            PreferredDroppingPointView(PreferredPickupPointViewListData: busViewModel.busServices, selectedItems: $servicesSelectedItem, viewModel: self.busViewModel)
                        } else {
                            PreferredDroppingPointView(PreferredPickupPointViewListData: busViewModel.busServices, selectedItems: $servicesSelectedItem, viewModel: self.busViewModel)
                        }
                    }
                }
                
                
                
                Color.gray.frame(height: 1 / UIScreen.main.scale)
                    .padding(.bottom,10)
                Button("Continue") {
                   dismiss()
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
    PreferredBusPartner(placeholderText: "preffered location", pageType: .PreferredDroppingPoint, busViewModel: BusServiceViewModel())
}



struct PreferredBusPartnerView : View {
@ObservedObject var viewModel : PreferredBusPartnerViewModel
   
    @Binding var selectedItems:  [Operators]
    var body: some View {
        CreateListView(listData: viewModel.fetchBusPartner, selectedItems: $selectedItems)
    }
}
struct PreferredDroppingBoardingView : View {
    @ObservedObject var viewModel : BusServiceViewModel
    @Binding var selectedItems:  [BusService]
    var body: some View {
        PreferredBoardingPointView(listData: viewModel.busServices, selectedItems: $selectedItems, viewModel: self.viewModel)
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


struct PreferredBoardingPointView: View {
    var listData : [BusService]
    @Binding var selectedItems: [BusService]
    @ObservedObject var viewModel: BusServiceViewModel
    @State var pickupPointIndex: [String]? = []
    @State var dropPointIndex: [String]? = []
    @State var onFirstPage : Bool = false
    @State var isPickupSelected : Bool = false
    @State var isDropSelected : Bool = false
    var body: some View {
        List {
            ForEach(viewModel.busServices.indices, id: \.self) { index in
                ForEach(viewModel.busServices[index].boardingInfo, id: \.self) { location in
                    
                    let locationText = location.components(separatedBy: "^").first ?? ""
                    VStack{
                        HStack {
                            Text(locationText)
                            Spacer()
                            Image(systemName: determineImageName(for: locationText))
                                .onTapGesture {
                                    handleSelection(for: locationText)
                                }
                        }
                        .padding(.vertical, 10)
                    }
                }
            }
        }
        .onAppear {
            printAllData()
            
        }
        .listStyle(.plain)
    }
            
          
    
    func handleSelection(for index: String) {
            if onFirstPage {
                if !(pickupPointIndex?.contains(index) ?? true) {
                    pickupPointIndex?.append(index)
                    isPickupSelected = true
                    onFirstPage = false
                } else {
                }
            } else {
                if !(pickupPointIndex?.contains(index) ?? true) {
                    pickupPointIndex?.append(index)
                    isDropSelected = true
                } else {
                    pickupPointIndex?.removeAll(where: { str in
                        if index == str {
                            return true
                        }
                        return false
                    })
                }
            }
        }
    func determineImageName(for index: String) -> String {
           if onFirstPage {
               return !(pickupPointIndex?.contains(index) ?? true) ? "square" : "checkmark.square.fill"
           } else {
               return !(pickupPointIndex?.contains(index) ?? true) ? "square" : "checkmark.square.fill"
           }
       }
    
    
    private func printAllData() {
        for (index, service) in viewModel.busServices.enumerated() {
            print("Bus Service \(index + 1):")
            for location in service.boardingInfo {
                print("- \(location)")
            }
            print()
        }
    }
}


struct PreferredDroppingPointView: View {
    @State var PreferredPickupPointViewListData: [BusService]
    @Binding var selectedItems: [BusService]
    @State var processedPickupInfos: [String] = []  // Ensure correct type
    @State var processedBoardingInfo: [String] = []
    @StateObject var viewModel: BusServiceViewModel
    @State var onFirstPage : Bool = false
    @State var isPickupSelected : Bool = false
    @State var isDropSelected : Bool = false
    @State var pickupPointIndex: [String]? = []
    @State var dropPointIndex: [String]? = []
    @State var secondLocationName: [String]? = []
    @State var uniqueLocationName: Set<String> = []
    var body: some View {
        List {

               
                ForEach(Array(uniqueLocationName), id: \.self) { location in
                        VStack(){
                        HStack {
                            Text("\(location)")
                        
                                Spacer()
                                Image(systemName: determineImageName(for: location))
                                    .onTapGesture {
                                        handleSelection(for: location)
                                    }
                           
                            
                        }
                    }
                }
            }
            .padding(.vertical,10)
   
        .onAppear {

                populateSecondLocationNames()
                uniqueLocationNames()
         
            }
            
    }
    
    func populateSecondLocationNames() {
        for index in viewModel.busServices.indices {
            for location in viewModel.busServices[index].droppingInfo {
                let locationName = secondWord(from: location)
                self.secondLocationName?.append(locationName)
            }
        }
    }
    
    func uniqueLocationNames() {
        if let loactionName = secondLocationName  {
            uniqueLocationName = Set(loactionName)

        }else { print("") }
    }
    func handleSelection(for index: String) {
        if onFirstPage {
            if !(pickupPointIndex?.contains(index) ?? true) {
                pickupPointIndex?.append(index)
                isPickupSelected = true
                onFirstPage = false
            }
            else {
                pickupPointIndex?.removeAll(where: { str in
                    if str == index
                    {
                        return true
                    }
                    return false
                })
            }
        } else {
            if !(dropPointIndex?.contains(index) ?? true) {
                dropPointIndex?.append(index)
                isDropSelected = true
            }
            else {
                dropPointIndex?.removeAll(where: { str in
                    if str == index
                    {
                        return true
                    }
                    return false
                })
            }
        }
    }
    func determineImageName(for index: String) -> String {
           if onFirstPage {
               return !(pickupPointIndex?.contains(index) ?? true) ? "square" : "checkmark.square.fill"
           } else {
               return !(dropPointIndex?.contains(index) ?? true) ? "square" : "checkmark.square.fill"
}
       }
    
    func secondWord(from string: String) -> String {
        let components = string.components(separatedBy: "^")
        if components.count >= 2 {
            return components[1]
        } else {
            return ""
        }
    }
    
    func printAllData() {
        for (index, service) in viewModel.busServices.enumerated() {
            print("Bus Service \(index + 1):")
            for location in service.boardingInfo {
                print("- \(location)")
            }
            print()
        }
    }
}
