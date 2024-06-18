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
                        
                    }) {
                        Image("Chevron_right")
                    }
                    .onTapGesture {
                        dismiss()
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
                        
                    case .PreferredPickupPoint:
                        if viewModel.preferredDroppingPickUPPointSearchResult != nil {
                            PreferredBoardingPointView(selectedItems: $servicesSelectedItem, viewModel: self.busViewModel)
                        } else {
                            PreferredBoardingPointView(selectedItems: $servicesSelectedItem, viewModel: self.busViewModel)
                        }
                    case .PreferredDroppingPoint :
                        if viewModel.preferredDroppingPickUPPointSearchResult != nil {
                            PreferredBoardingPointView(selectedItems: $servicesSelectedItem, viewModel: self.busViewModel)
                        } else {
                            PreferredBoardingPointView(selectedItems: $servicesSelectedItem, viewModel: self.busViewModel)
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
    
    @Binding var selectedItems: [BusService]
    @ObservedObject var viewModel: BusServiceViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.busServices.indices, id: \.self) { index in
                ForEach(viewModel.busServices[index].boardingInfo, id: \.self) { location in
                    HStack {
                        Text(location)
                        Spacer()
                        
                            .onTapGesture {
                            }
                    }
                }
            }
            .listStyle(.plain)
            .onAppear {
                printAllData()
               
            }
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



struct PreferredDroppingPointView : View {
    @State var PreferredPickupPointViewListData: [BusService]
    @Binding var selectedItems:  [BusService]
    @State var processedPickupInfo = []
    @State var processedBoardingInfo : [String] = []
    @StateObject var viewModel: BusServiceViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.busServices.indices, id: \.self) { index in
                ForEach(viewModel.busServices[index].droppingInfo, id: \.self) { location in
                    
                    HStack {
                        Text(location)
                    Spacer()
                        
                    }
                    
                    .onTapGesture {
                        
                    }
                }
                .listStyle(.plain)
                .onAppear {
                    printAllData()
                    
                }
            }
            
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

