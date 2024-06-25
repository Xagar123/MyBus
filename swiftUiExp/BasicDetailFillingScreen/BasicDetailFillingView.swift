//
//  BasicDetailFillingView.swift
//  swiftUiExp
//
//  Created by Shubam Vijay Yeme on 18/06/24.
//

import SwiftUI


struct BasicDetailFillingView: View {
    @State var screenTitle: String = "Review booking"
    @State var contactTextField = ""
    @State var mailTextField = ""
    @State var isPickupSelected = true
    @State var isDropSelected = true
    
    var body: some View {
       
            VStack(alignment: .leading){
                ScrollView{
                    topBar(title: $screenTitle)
                        .padding(.top,16)
                    SepratorLine(leading: 0, trailing: 0, topPadding: 5)
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 236)
                        .foregroundStyle(Color(hex: "#222222"))
                        .overlay {
                            RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1).foregroundStyle(Color(hex: "#333333"))
                            getView()
                        }
                        .padding(.horizontal, 16)
                    
                    headingView(topHeading: "Traveller Details",subHeading: "Fill traveler details corresponding to the seats", seatNumber: "0/2")
                    travellerDetailView()
                    
                    
                    SepratorLine(leading: 16, trailing: 16, topPadding: 16)
                    
                    headingView(topHeading: "Contact details",subHeading: "Booking details will be shared here", seatNumber: "")
                    contactDetailView(contactTextField: $contactTextField, mailTextField: $mailTextField)
                    
                    SepratorLine(leading: 16, trailing: 16, topPadding: 16)
                    
                    headingView(topHeading: "Cancellation & refund policy",subHeading: "", seatNumber: "")
                    SepratorLine(leading: 16, trailing: 16, topPadding: 16)
                    
                    
                    
                    
                }.background(Color(hex: "#111111"))
                SepratorLine(leading: 0, trailing: 0, topPadding: 0)
                bottomContinueBar(isPickupSelected: $isPickupSelected, isDropSelected: $isDropSelected)
                
        }
            .background(Color(hex: "#111111"))
    }
    
    @ViewBuilder
    func getView() -> some
     View {
        VStack{
            HStack{
                locationNameText()
                Spacer()
                locationNameText()
            }
            
            Rectangle()
                .frame(height: 2)
                .padding(.top,16)
                .foregroundStyle(
                    LinearGradient(
                    stops: [
                    Gradient.Stop(color: Color(red: 0.26, green: 0.14, blue: 0.67), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.94, green: 0.14, blue: 0.24), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0, y: 0.5),
                    endPoint: UnitPoint(x: 1, y: 0.5)
                    ))
                .overlay {
                    HStack{
                        Circle()
                            .foregroundStyle(Color(hex: "#4224AC"))
                        Spacer()
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 94,height: 24)
                            .foregroundStyle(Color(hex: "#464646"))
                            .overlay {
                                Text("10 hrs 04 mins")
                                    .font(.system(size: 11))
                                    .foregroundStyle(Color(hex: "#CCCCCC"))
                            }
                        Spacer()
                        Circle()
                            .foregroundStyle(Color(hex: "#EF233C"))
                    }
                    .offset(y: 8)
                        .frame(height: 08)
                    
                    
                }
            HStack{
                timeAnddateText()
                Spacer()
                timeAnddateText()
            }.padding(.top,16)
            
            SepratorLine(leading: -16, trailing: -16, topPadding: 16)
            HStack{
                busAndSeatText()
                Spacer()
                busAndSeatText()
            }.padding(.top,16)
            
            
        }.padding(.horizontal,16)
    }
}

#Preview {
    BasicDetailFillingView()
}




struct headingView: View {
    var topHeading: String
    var subHeading: String
    var seatNumber: String
    var body: some View {
        HStack(alignment: .top){
            VStack(alignment: .leading){
                Text(topHeading)
                    .foregroundStyle(Color.iceWhiteColorFEFEFE)
                    .font(.bold(size: 20))
                    .padding(.bottom,5)
                if subHeading != ""{
                    Text(subHeading)
                        .foregroundStyle(Color(hex: "#888888"))
                        .font(.regular(size: 14))
                }
            }
            Spacer()
            if seatNumber != ""{
                Text(seatNumber)
                    .foregroundStyle(Color(hex: "#888888"))
                    .font(.regular(size: 12))
            }

        }.padding(.horizontal, 16)
            .padding(.top, 16)
    }
}

struct contactDetailView: View {
    @Binding var contactTextField: String
    @Binding var mailTextField: String
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 56)
                .foregroundStyle(Color(hex: "#181818"))
                .overlay {
                    RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1)
                        .foregroundStyle(Color(hex: "#333333"))
                    HStack{
                        Text("+ 91")
                            .foregroundStyle(Color.white)
                            .font(.medium(size: 16))
                        Rectangle()
                            .frame(width: 1)
                            .foregroundStyle(Color(hex: "#333333"))
                            .padding(.top,16)
                            .padding(.bottom,16)
                        TextField("", text: $contactTextField, prompt: Text("Phone number").foregroundColor(Color(hex: "#888888")).font(.regular(size: 16)))
                            .foregroundStyle(Color.white)
                            .keyboardType(.numberPad)
                            .font(.regular(size: 16))
                    }.padding(.horizontal,16)
                    
                }
            
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 56)
                .foregroundStyle(Color(hex: "#181818"))
                .overlay {
                    RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1)
                        .foregroundStyle(Color(hex: "#333333"))
                        .overlay {
                            TextField("", text: $mailTextField, prompt: Text("Phone number").foregroundColor(Color(hex: "#888888")).font(.regular(size: 16)))
                                .foregroundStyle(Color.white)
                                .keyboardType(.numberPad)
                                .font(.regular(size: 16))
                                .padding(.leading,16)
                        }
                    
                }
        }.padding(.horizontal,16)
    }
}

struct travellerDetailView: View {
    var body: some View {
        HStack{
            RoundedRectangle(cornerRadius: 8)
                .frame(height: 48)
                .foregroundStyle(Color.clear)
                .overlay {
                    RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1)
                        .foregroundStyle(Color(hex: "#333333"))
                        Text("+  Add traveller")
                        .foregroundStyle(Color(hex: "#3287FA"))
                        .font(.semiBold(size: 16))
                    
                }
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 48,height: 48)
                .foregroundStyle( LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.23, green: 0.23, blue: 0.23), location: 0.00),
                        Gradient.Stop(color: Color(red: 0.21, green: 0.21, blue: 0.21).opacity(0), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0, y: 0.5),
                    endPoint: UnitPoint(x: 1, y: 0.5)
                ))
                .overlay {
                    VStack{
                        Image(systemName: "carseat.right.fill")
                            .foregroundColor(Color.white)
                        
                        Text("S21")
                            .foregroundStyle(Color.white)
                            .font(.regular(size: 10))
                            .padding(.top,2)
                    }
                }
            
        }.padding(.horizontal,16)
    }
}
