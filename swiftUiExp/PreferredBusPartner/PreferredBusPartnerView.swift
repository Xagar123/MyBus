import SwiftUI

struct PreferredBusPartnerView: View {
    // MARK: - Properties
    
    @ObservedObject var viewModel: PreferredBusPartnerViewModel
    @Binding var selectedItems: [Operators]

    // MARK: - Body
    var body: some View {
        CreateListView(listData: $viewModel.fetchBusPartner, selectedItems: $selectedItems)
    }
}

struct CreateListView: View {
    // MARK: - Properties
    @Binding var listData: [Operators]
    @Binding var selectedItems: [Operators]

    // MARK: - Body
    var body: some View {
        @StateObject var viewModel = PreferredBusPartnerViewModel()
        
        List(listData, id: \.operator_id) { item in
            VStack {
                HStack {
                    Text("\(item.operater_name)")
                        .fontWeight(.medium)
                        .font(.custom("Metropolis", size: 16))
                        .foregroundColor(Color(hex: "#EEEEEE"))
                    Spacer()
                    Image(systemName: selectedItems.contains(where: { $0.operator_id == item.operator_id }) ? "checkmark.square.fill" : "square")
                        .foregroundColor(Color(hex: "#EEEEEE"))
                }
            }
            .padding(.vertical, 10)
            .onTapGesture {
                if selectedItems.contains(item) {
                    selectedItems.removeAll { $0 == item }
                } else {
                    selectedItems.append(item)
                }
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        
        .background(Color(hex: "#111111"))
    
    }
}
