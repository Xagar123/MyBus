import SwiftUI

struct BusMoreInfoSectionsListView: View {
    var busSectionsList: [BusSectionList]
    @Binding var selectedTab: String
    
    var body: some View {
        GeometryReader { geometry in
            LazyHGrid(rows: [GridItem(.flexible())], alignment: .center) {
                ForEach(busSectionsList, id: \.self) { item in
                    VStack(spacing: 8) {
                        Image(item.imageURL, bundle: Bundle(identifier: "com.multiverse.iOS-BUS"))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(selectedTab == item.title ? .red : .primary)
                            .tint(selectedTab == item.title ? .red : .primary)
                            .frame(width: geometry.size.width / 4, height: 20)
                            .foregroundColor(selectedTab == item.title ? .red : .primary)
                        Text(item.title)
                            .font(.medium(size: 14))
                            .foregroundColor(selectedTab == item.title ? .red : .primary)
                    }
                    .onTapGesture {
                        selectedTab = item.title
                    }
                }
            }
            .frame(width: geometry.size.width, height: 40)
        }
        .frame(height: 40)
        .padding([.top, .bottom], 24)
    }
}

//#Preview {
//    let selectedTab = Binding.constant("Amenities")
//    return BusMoreInfoSectionsListView(busSectionsList: [BusSectionList(title: "", imageURL: "")], selectedTab: selectedTab)
//        .preferredColorScheme(.dark)
//}
