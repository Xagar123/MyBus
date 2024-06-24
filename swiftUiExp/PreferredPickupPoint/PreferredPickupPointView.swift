import SwiftUI

struct PreferredBoardingPointView: View {
    // MARK: - Properties
    @Binding var listData: [BusService]
    @Binding var selectedItems: [BusService]
    
    
    @State private var pickupPointIndex: [String] = []
    @State private var dropPointIndex: [String] = []
    @State private var onFirstPage: Bool = false
    @State private var isPickupSelected: Bool = false
    @State private var isDropSelected: Bool = false
    @State private var locationText: String = ""
    @State private var secondLocationNames: [String] = []
    @ObservedObject var viewModel: PreferredBusPartnerViewModel
    // MARK: - Body
    var body: some View {
        List {
            ForEach(Array(viewModel.searchInDroppingAndPickup), id: \.self) { location in
                VStack {
                    HStack {
                        Text(location)
                            .foregroundColor(Color(hex: "#EEEEEE"))
                        Spacer()
                        Image(systemName: determineImageName(for: location))
                            .renderingMode(.template)
                            .foregroundColor(Color(hex: "#888888"))
                            .onTapGesture {
                                handleSelection(for: location)
                            }
                    }
                }
                .padding(.vertical, 10)
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
        }
        .background(Color(hex: "#111111"))
        .listStyle(.plain)
        .listRowSeparator(.hidden)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                populateFirstWord()
                viewModel.UniqueLocations = Array(Set(secondLocationNames))
                viewModel.searchInDroppingAndPickup = viewModel.UniqueLocations
            }
        }
    }
    
    // MARK: - Methods
    private func populateFirstWord() {
        print(listData)
        for busService in listData {
            for location in busService.boardingInfo {
                if let firstWord = location.components(separatedBy: "^").first {
                    secondLocationNames.append(firstWord)
                }
            }
        }
    }
    
    private func handleSelection(for location: String) {
        if onFirstPage {
            if let index = pickupPointIndex.firstIndex(of: location) {
                pickupPointIndex.remove(at: index)
            } else {
                pickupPointIndex.append(location)
                isPickupSelected = true
                onFirstPage = false
            }
        } else {
            if let index = dropPointIndex.firstIndex(of: location) {
                dropPointIndex.remove(at: index)
            } else {
                dropPointIndex.append(location)
                isDropSelected = true
            }
        }
    }
    
    private func determineImageName(for location: String) -> String {
        if onFirstPage {
            return pickupPointIndex.contains(location) ? "checkmark.square.fill" : "square"
        } else {
            return dropPointIndex.contains(location) ? "checkmark.square.fill" : "square"
        }
    }
    
    private func printAllData() {
        for (index, service) in listData.enumerated() {
            print("Bus Service \(index + 1):")
            for location in service.boardingInfo {
                print("- \(location)")
            }
            print()
        }
    }
}
struct PreferredBoardingView: View {
   
    @ObservedObject var ViewModel: PreferredBusPartnerViewModel
    @Binding var selectedItems: [BusService]
    
    var body: some View {
        PreferredBoardingPointView(
            listData: $ViewModel.preferredDroppingPickUPPointSearchResult,
            selectedItems: $selectedItems, viewModel: ViewModel
        )
    }
}

// MARK: - Preview
struct PreferredBoardingPointView_Previews: PreviewProvider {
    @State static var selectedItems = [BusService]()
    static var previews: some View {
        PreferredBoardingPointView(
            listData: .constant([]),
            selectedItems: $selectedItems, viewModel: PreferredBusPartnerViewModel()
        )
    }
}

