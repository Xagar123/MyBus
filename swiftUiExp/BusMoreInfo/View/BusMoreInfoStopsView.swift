import SwiftUI

struct boardingDroppingPoints: Hashable {
    var time: String
    var point: String
}

struct BusMoreInfoStopsView: View {
    @State var boardingPoints: BoardingDroppingHeaderPoints
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(boardingPoints.boardingPointTitle)
                        .padding(EdgeInsets(top: 6, leading: 24, bottom: 6, trailing: 24))
                        .font(.semiBold(size: 14))
                        .foregroundColor(boardingPoints.selectedBoardingPoint ? .red : .primary) // Adjust color based on selection
                    Divider()
                        .padding([.leading, .trailing], 0)
                        .frame(height: 4)
                        .overlay(
                            Rectangle()
                                .fill(boardingPoints.selectedBoardingPoint ? Color.red : .clear) // Adjust color based on selection
                                .frame(height: 3)
                                .padding(.leading, 5)
                        )
                }
                .onTapGesture {
                    boardingPoints.selectedBoardingPoint = true
                }
                
                Spacer(minLength: 0)
                
                VStack {
                    Text("Dropping Points")
                        .padding(EdgeInsets(top: 6, leading: 24, bottom: 6, trailing: 24))
                        .font(.semiBold(size: 14))
                        .foregroundColor(boardingPoints.selectedBoardingPoint ? .primary : .red) // Adjust color based on selection
                    Divider()
                        .frame(height: 3)
                        .padding([.leading, .trailing], 0)
                        .overlay(
                            Rectangle()
                                .fill(boardingPoints.selectedBoardingPoint ? .clear : Color.red) // Adjust color based on selection
                                .frame(height: 3)
                                .padding(.trailing, 5)
                        )
                }
                .onTapGesture {
                    boardingPoints.selectedBoardingPoint = false
                }
            }
            
            let points = boardingPoints.selectedBoardingPoint ? boardingPoints.boardingPoints : boardingPoints.droppingPoints
            
            ForEach(points, id: \.self) { point in
                BusMoreInfoStopsRowSwiftUIView(time: point.time, stop: point.point)
            }
            
            Divider()
                .frame(height: 1)
                .overlay(Color(hex: "#333333"))
            
            HStack {
                Button {
                    
                } label: {
                    HStack(spacing: 0) {
                        Text("Show all")
                            .foregroundColor(.red)
                            .font(.semiBold(size: 12))
                        
                        Image("Chevron_down", bundle: Bundle(identifier: "com.multiverse.iOS-BUS"))
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .padding(.vertical, 0)
                }
            }
            .padding(.vertical, 0)
        }
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
        .background(Color(hex: "#181818"))
        .clipShape(
            RoundedRectangle(cornerRadius: 16)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(hex: "#333333"), lineWidth: 1)
        }
        .padding(.bottom, 8)
    }
}


struct BusMoreInfoStopsRowSwiftUIView: View {
    var time: String
    var stop: String
    
    var body: some View {
        HStack {
            Text(time)
                .font(.semiBold(size: 14))
                .frame(width: 50)
            Spacer(minLength: 60)
            Text(stop)
                .font(.semiBold(size: 14))
            Spacer()
        }
        .padding(EdgeInsets(top: 12, leading: 32, bottom: 12, trailing: 32))
    }
}


#Preview {
    let dummyBoardingPoints = [
        BoardingDroppingPoint(time: "20:00", point: "Bellandur"),
        BoardingDroppingPoint(time: "21:00", point: "Bellandur"),
        BoardingDroppingPoint(time: "22:00", point: "Bellandur"),
        BoardingDroppingPoint(time: "23:00", point: "Bellandur")
    ]
    return BusMoreInfoStopsView(boardingPoints: BoardingDroppingHeaderPoints(boardingPointTitle: "Boarding Points", droppingPointTitle: "Dropping Points", boardingPoints: dummyBoardingPoints, droppingPoints: dummyBoardingPoints, selectedBoardingPoint: true))
        .preferredColorScheme(.dark)
}
