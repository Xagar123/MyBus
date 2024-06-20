import SwiftUI

struct PreferredBusPartnerView : View {
@ObservedObject var viewModel : PreferredBusPartnerViewModel
   
    @Binding var selectedItems:  [Operators]
    var body: some View {
        CreateListView(listData: $viewModel.fetchBusPartner, selectedItems: $selectedItems)
    }
}
struct CreateListView : View {
    @Binding var listData: [Operators]
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


