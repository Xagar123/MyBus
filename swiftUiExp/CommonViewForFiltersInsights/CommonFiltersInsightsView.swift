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
                HeaderView(pageType: pageType)
                Color.gray.frame(height: 1 / UIScreen.main.scale)
                .padding(.bottom, 10)
                
                SearchBarView(placeholderText: placeholderText, textFieldIsTapped: $textFieldIsTapped, pageType: $pageType, viewModel: viewModel)
                
 
                
                FiltersContentView(pageType: pageType, viewModel: viewModel, selectedItems: $selectedItems, servicesSelectedItem: $servicesSelectedItem)
                
                Color.gray.frame(height: 1 / UIScreen.main.scale)
                .padding(.bottom, 10)
           
                ContinueButton {
                    processSelectedData()
                    dismiss()
                    
                }
            }
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
                print("Selected Pickup Point: \(String(describing: servicesSelectedItem.first?.boardingInfo))")
            case .PreferredDroppingPoint :
                print("Selected Dropping Point : \(servicesSelectedItem)")
                
            }
        }
}

// MARK: - HeaderView
struct HeaderView: View {
    var pageType: ScreenType
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image("Chevron_right")
            }
            .padding()
            
            Text(pageType.rawValue)
                .fontWeight(.bold)
                .font(.custom("Metropolis", size: 20))
        }
        .frame(width: 360, height: 60)
        .padding(.trailing, 150)
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
            
            TextField(placeholderText, text: $viewModel.PreferredBusPartnerSearchText)
                .foregroundColor(.white)
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
        .frame(width: 328, height: 56)
        .padding(5)
        .background(Color(hex: "#181818"))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(textFieldIsTapped ? Color(hex: "#EEEEEE") : Color(hex: "#333333"), lineWidth: 1)
        )
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
                                  
                 
                PreferredBoardingPointView(listData: $viewModel.preferredDroppingPickUPPointSearchResult, selectedItems: $servicesSelectedItem)
                                  
            case .PreferredDroppingPoint:
              
                PreferredDroppingPointView(PreferredPickupPointViewListData: $viewModel.preferredDroppingPickUPPointSearchResult, servicesSelectedItem: $servicesSelectedItem, viewModel: viewModel.viewModels)

            }
        }
    }
}

// MARK: - ContinueButton
struct ContinueButton: View {
    var action: () -> Void
    
    var body: some View {
        Button("Continue") {
            
        }
        .frame(width: 328, height: 48, alignment: .center)
        .background(Color.white)
        .cornerRadius(8)
        .foregroundColor(.black)
        .fontWeight(.bold)
        .onTapGesture {
            action()
        }
    }
}

// MARK: - Preview
#Preview {
    CommonFiltersInsightsView(placeholderText: "prefered location", pageType: .preferredBusPartner)
}
