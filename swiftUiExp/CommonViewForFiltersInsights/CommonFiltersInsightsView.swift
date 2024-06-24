import SwiftUI

struct CommonFiltersInsightsView: View {
    // MARK: - Properties
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = PreferredBusPartnerViewModel()
    @State var preferredBusPartner = [Any]()
    var placeholderText: String
    @State var selectedItems = [Operators]()
    @State var servicesSelectedItem = [BusService]()
    @State var pageType: ScreenType
    @State var textFieldIsTapped = false
 
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        self.dismiss()
                    }){
                        Image("Chevron_right")
                    }
                    .padding()
                    .onTapGesture(perform: {
                        self.dismiss()
                    })
                    
                    Text(pageType.rawValue)
                        .fontWeight(.bold)
                        .font(.custom("Metropolis", size: 20))
                        .foregroundColor(Color(hex: "#EEEEEE"))
                }
               
                .frame(width: 360, height: 60)
                .padding(.trailing, 150)
                
                
                Color.gray.frame(height: 1 / UIScreen.main.scale)
                .padding(.bottom, 10)
                
                SearchBarView(placeholderText: placeholderText, textFieldIsTapped: $textFieldIsTapped, pageType: $pageType, viewModel: viewModel)
                
 
                
                FiltersContentView(pageType: pageType, viewModel: viewModel, selectedItems: $selectedItems, servicesSelectedItem: $servicesSelectedItem)
                
                Color.gray.frame(height: 1 / UIScreen.main.scale)
                .padding(.bottom, 10)
                Button(action: {
                    dismiss()
                    processSelectedData()
                }, label: {
                    Text("Continue")
                })
                .frame(width: 328, height: 48, alignment: .center)
                .background(Color.white)
                .cornerRadius(8)
                .foregroundColor(.black)
                .fontWeight(.bold)
                .onTapGesture {
                    dismiss()
                }
                
            }
            .background(Color(hex: "#111111"))
            .onAppear {
                viewModel.pageType = pageType
                viewModel.fetchData()

            }
        }
    }
    func processSelectedData() {
            switch pageType {
            case .preferredBusPartner:
                print("Selected Bus Partners: \(selectedItems)")
            case .PreferredPickupPoint :
                print("Selected Pickup Point: \(servicesSelectedItem)")
            case .PreferredDroppingPoint :
                print("Selected Dropping Point : \(servicesSelectedItem)")
                
            }
        }
}

// MARK: - SearchBarView
struct SearchBarView: View {
    var placeholderText: String
    @Binding var textFieldIsTapped: Bool
    @Binding var pageType: ScreenType
    @ObservedObject var viewModel: PreferredBusPartnerViewModel
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color(hex: "#D9D9D9"))
                .padding(.leading, 10)
            TextField("Search", text: $viewModel.PreferredBusPartnerSearchText)
                           .textFieldStyle(CustomTextFieldStyle(placeholderColor:Color(hex: " #EEEEEE"), textColor: Color(hex:  "#888888")))
                .onTapGesture {
                    textFieldIsTapped.toggle()
                }
                .onAppear {
                    viewModel.searchEnable(pageType: pageType)
                }
            
            if !viewModel.PreferredBusPartnerSearchText.isEmpty {
                Button("", systemImage: "multiply") {
                    viewModel.PreferredBusPartnerSearchText = ""
                    textFieldIsTapped = false
                }
                .foregroundColor(.white)
            }
        }
        .frame(height: 56)
       
        .background(Color(hex: "#181818"))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(textFieldIsTapped ? Color(hex: "#EEEEEE") : Color(hex: "#333333"), lineWidth: 1)
        )
        .padding(.leading, 20)
        .padding(.trailing,20)
    }
}

// MARK: - FiltersContentView
struct FiltersContentView: View {
    var pageType: ScreenType
    @ObservedObject var viewModel: PreferredBusPartnerViewModel
    @Binding var selectedItems: [Operators]
    @Binding var servicesSelectedItem: [BusService]
    
    var body: some View {
        VStack {
            switch pageType {
            case .preferredBusPartner:
               
                    CreateListView(listData: $viewModel.preferredBusPartnerSearchResult, selectedItems: $selectedItems)
                
                
            case .PreferredPickupPoint:
                                  
                 
                PreferredDroppingAndPickUpPointView(PreferredPickupPointViewListData: $viewModel.preferredDroppingPickUPPointSearchResult, servicesSelectedItem: $servicesSelectedItem, viewModel: viewModel.viewModels, viewModels: viewModel)
                                  
            case .PreferredDroppingPoint:
              
                PreferredDroppingAndPickUpPointView(PreferredPickupPointViewListData: $viewModel.preferredDroppingPickUPPointSearchResult, servicesSelectedItem: $servicesSelectedItem, viewModel: viewModel.viewModels, viewModels: viewModel)

            }
        }
    }
}
import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    var placeholderColor: Color
    var textColor: Color
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .foregroundColor(textColor) // Set the text color
            
            .overlay(
                configuration
                    .foregroundColor(placeholderColor) // Set the placeholder color
            )
    }
}
// MARK: - Preview
#Preview {
    CommonFiltersInsightsView(placeholderText: "prefered location", pageType: .PreferredPickupPoint)
}
