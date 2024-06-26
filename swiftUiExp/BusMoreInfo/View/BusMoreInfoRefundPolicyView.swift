import SwiftUI

struct BusMoreInfoRefundPolicyView: View {
    var busRefundPolicy: [BusRefundPolicy]
    
    var body: some View {
        VStack {
            Grid(verticalSpacing: 0) {
                GridRow(alignment: .center) {
                    HStack {
                        Text("Cancellation Time")
                            .font(.semiBold(size: 14))
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        Spacer()
                    }
                    Divider()
                        .frame(width: 1, height: 50)
                        .frame(maxWidth: 1, maxHeight: .infinity)
                        .overlay(Color(hex: "#333333"))
                    Text("Refund Amount")
                        .font(.semiBold(size: 14))
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    
                }
                .padding(0)
                
                Divider()
                    .frame(height: 1)
                    .overlay(Color(hex: "#333333"))
                
                ForEach(busRefundPolicy, id: \.self) { busRefundPolicy in
                    GridRow(alignment: .center) {
                        HStack {
                            Text(busRefundPolicy.cancellationTime)
                                .font(.regular(size: 12))
                                .frame(alignment: .leading)
                                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                            Spacer()
                        }
                        Divider()
                            .frame(width: 1, height: 50)
                            .frame(maxWidth: 1, maxHeight: .infinity)
                            .overlay(Color(hex: "#333333"))
                        HStack(spacing: 0) {
                            Text(busRefundPolicy.refundAmount)
                                .font(.semiBold(size: 12))
                            Text(busRefundPolicy.percentage)
                                .font(.regular(size: 12))
                                .foregroundColor(Color(hex: "#888888"))
                        }
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    }
                    .padding(0)
                    
                    Divider()
                        .frame(height: 1)
                        .overlay(Color(hex: "#333333"))
                }
            }
            .background(Color(hex: "#181818"))
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .clipShape(
                RoundedRectangle(cornerRadius: 8)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(hex: "#333333"), style: .init(lineCap: .round, lineJoin: .round))
            }
            .padding(.top, 8)
        }
        
        HStack(alignment: .top, spacing: 2) {
            Text("*")
            Text("The refund amount is an estimate. Please note, there's an additional Rs. 15 fee per seat for cancellations.\nUnfortunately, we can't process partial cancellations.")
        }
        .foregroundColor(Color(hex: "#888888"))
        .font(.medium(size: 12))
        .padding(.vertical, 12)
    }
}

#Preview {
    BusMoreInfoRefundPolicyView(busRefundPolicy: [ BusRefundPolicy(cancellationTime: "Before 09-Aug 20:00", refundAmount: "₹1260", percentage: "(90%)"),
                                                   BusRefundPolicy(cancellationTime: "Before 09-Aug 21:00 & 06-Sep 20:00", refundAmount: "₹1260", percentage: "(90%)"),
                                                   BusRefundPolicy(cancellationTime: "Before 09-Aug 22:00", refundAmount: "₹1260", percentage: "(90%)"),
                                                   BusRefundPolicy(cancellationTime: "Before 09-Aug 23:00 & 06-Sep 20:00", refundAmount: "₹1260", percentage: "(90%)"),
                                                   BusRefundPolicy(cancellationTime: "Before 09-Aug 00:00", refundAmount: "₹1260", percentage: "(90%)"),
                                                   BusRefundPolicy(cancellationTime: "Before 09-Aug 10:00 & 06-Sep 20:00", refundAmount: "₹1260", percentage: "(90%)"),
                                                   BusRefundPolicy(cancellationTime: "Before 09-Aug 12:00", refundAmount: "₹1260", percentage: "(90%)"),
                                                   BusRefundPolicy(cancellationTime: "Before 09-Aug 13:00 & 06-Sep 20:00", refundAmount: "₹1260", percentage: "(90%)")])
        .preferredColorScheme(.dark)
}
