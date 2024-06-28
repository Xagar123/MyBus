import SwiftUI

struct BusMoreInfoMainDetailsView: View {
    var busInfo: BusInfo
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(busInfo.name)
                    .font(.semiBold(size: 18))
                Text(busInfo.type)
                    .font(.regular(size: 12))
                    .foregroundColor(Color(hex: "#888888"))
            }
            
            Spacer()
            
            VStack(spacing: 2) {
                HStack(spacing: 0) {
                    Image("BusMoreInfoStar", bundle: Bundle(identifier: "com.multiverse.iOS-BUS"))
                        .resizable()
                        .frame(width: 16, height: 16)
                    Text(busInfo.rating)
                        .font(.semiBold(size: 12))
                }
                .foregroundColor(Color(hex: "#FEFEFE"))
                .padding(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 2))
                .background(Color(hex: "#29B865"))
                .cornerRadius(4)
                
                Text(busInfo.reviews)
                    .font(.regular(size: 12))
                    .foregroundColor(Color(hex: "#888888"))
            }
        }
        .padding(0)
    }
}

//#Preview {
//    BusMoreInfoMainDetailsView(busInfo: BusInfo(name: "Name", type: "Type", rating: "1.4", reviews: "12"))
//        .preferredColorScheme(.dark)
//}
