import SwiftUI
import Combine

struct PreferredDroppingAndPickUpPointView: View {
    // MARK: - Properties
    @Binding var PreferredPickupPointViewListData: [BusService]
    @Binding var servicesSelectedItem: [BusService] 
    @State private var processedPickupInfos: [String] = []
    @State private var processedBoardingInfo: [String] = []
    @StateObject var viewModel: BusServiceViewModel
    @State private var onFirstPage: Bool = false
    @State private var isPickupSelected: Bool = false
    @State private var isDropSelected: Bool = false
    @State private var pickupPointIndex: [String] = []
    @State private var dropPointIndex: [String] = []
    @State private var secondLocationNames: [String] = []
    
    @ObservedObject var viewModels : PreferredBusPartnerViewModel
    // MARK: - Body
    var body: some View {
        List {
            ForEach(viewModels.searchInDroppingAndPickup, id: \.self) { location in
                VStack {
                    HStack {
                        Text(location)
                            .foregroundColor(Color(hex: "#EEEEEE"))
                        Spacer()
                        Image(systemName: determineImageName(for: location))
                            .foregroundColor(Color(hex: "#EEEEEE"))
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
        .padding(.vertical, 10)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                populateSecondLocationNames()
                viewModels.UniqueLocations = Array(Set(secondLocationNames))
                viewModels.searchInDroppingAndPickup = viewModels.UniqueLocations
            }
        }
    }
    
    // MARK: - Methods
    private func populateSecondLocationNames() {
        for busService in PreferredPickupPointViewListData {
            for location in busService.droppingInfo {
                let locationName = secondWord(from: location)
                secondLocationNames.append(locationName)
               
            }
        }
    }
    
    private func handleSelection(for location: String) {
        if onFirstPage {
            toggleSelection(in: &pickupPointIndex, for: location)
            isPickupSelected = pickupPointIndex.contains(location)
            onFirstPage = !isPickupSelected
        } else {
            toggleSelection(in: &dropPointIndex, for: location)
            isDropSelected = dropPointIndex.contains(location)
        }
    }
    
    private func toggleSelection(in array: inout [String], for location: String) {
        if let index = array.firstIndex(of: location) {
            array.remove(at: index)
        } else {
            array.append(location)
        }
    }
    
    private func determineImageName(for location: String) -> String {
        if onFirstPage {
            return pickupPointIndex.contains(location) ? "checkmark.square.fill" : "square"
        } else {
            return dropPointIndex.contains(location) ? "checkmark.square.fill" : "square"
        }
    }
    
    private func secondWord(from string: String) -> String {
        let components = string.components(separatedBy: "^")
        return components.count >= 2 ? components[1] : ""
    }
    
    private func printAllData() {
        for (index, service) in PreferredPickupPointViewListData.enumerated() {
            print("Bus Service \(index + 1):")
            for location in service.droppingInfo {
                print("- \(location)")
            }
            print()
        }
    }
}

// MARK: - PreferredDroppingView

struct PreferredDroppingView: View {
    @ObservedObject var viewModel: BusServiceViewModel
    @ObservedObject var viewModels: PreferredBusPartnerViewModel
    @Binding var selectedItems: [BusService]
    
    var body: some View {
        PreferredBoardingPointView(
            listData: $viewModels.preferredDroppingPickUPPointSearchResult,
            selectedItems: $selectedItems, viewModel: viewModels
        )
    }
}

// MARK: - Preview

struct PreferredDroppingPointView_Previews: PreviewProvider {
    @State static var selectedItems = [BusService]()
    static var previews: some View {
        PreferredDroppingAndPickUpPointView(
            PreferredPickupPointViewListData: .constant([]),
            servicesSelectedItem: $selectedItems,
            viewModel: BusServiceViewModel(), viewModels: PreferredBusPartnerViewModel()
        )
    }
}
