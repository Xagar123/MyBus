import SwiftUI

struct BusMoreInfoTravelPolicy: Hashable {
    var image: String
    var title: String
    var subTitle: String
}

struct BusMoreInfoTravelPolicyView: View {
    var travelPolicy: [BusMoreInfoTravelPolicy]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(travelPolicy, id: \.self) { travel in
                HStack(alignment: .top, spacing: 8) {
                    Image(systemName: "person")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(travel.title)
                            .font(.semiBold(size: 12))
                            .foregroundColor(Color(hex: "#EEEEEE"))
                        Text(travel.subTitle)
                            .font(.regular(size: 12))
                            .foregroundColor(Color(hex: "#888888"))
                    }
                }
                .padding(.all, 12)
            }
        }
    }
}


#Preview {
    BusMoreInfoTravelPolicyView(travelPolicy: [BusMoreInfoTravelPolicy(image: "", title: "Do need to buy a ticket for my child?", subTitle: "please purchase a ticket for children above the age of 6")])
        .preferredColorScheme(.dark)
}
