import SwiftUI

struct BusMoreInfoAmenities {
    var imageName: String
    var title: String
}

struct BusMoreInfoAmenitiesView: View {
    let amenities: [BusAmenity]

    var body: some View {
        VStack(alignment: .leading) {
            FlowLayout(items: amenities) { item in
                HStack(spacing: 8) {
                    Image(systemName: item.imageName)
                        .resizable()
                        .frame(width: 16, height: 16)
                        .padding(.vertical, 8)
                    Text(item.title)
                        .font(.regular(size: 12))
                        .padding(.vertical, 12)
                }
                .foregroundColor(Color(hex: "#EEEEEE"))
                .padding(.horizontal, 12)
                .background(Color(hex: "#181818"))
                .cornerRadius(24)
            }
            .padding([.leading, .trailing], 0)
            .padding(.vertical, 0)
        }
        .padding([.leading, .trailing], 0)
    }
}


//#Preview {
//    BusMoreInfoAmenitiesView(amenities: [BusAmenity(imageName: "", title: "")])
//        .preferredColorScheme(.dark)
//}
