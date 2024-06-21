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
                    Spacer()
                    Image(systemName: selectedItems.contains(where: { $0.operator_id == item.operator_id }) ? "checkmark.square.fill" : "square")
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
        }
        .listStyle(.plain)
    }
}
