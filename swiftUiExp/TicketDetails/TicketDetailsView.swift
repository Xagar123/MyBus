//
//  TicketDetailsView.swift
//  swiftUiExp
//
//  Created by Sagar on 19/06/24.
//

import SwiftUI

struct TicketDetailsView: View {
    
    var body: some View {
        VStack {
            NavigationHeaderView()
//            SepratorLine(leading: 0, trailing: 0, topPadding: 0)
//            Spacer()
            
            PaymentDetailView()
//            Spacer()
            SepratorLine(leading: 0, trailing: 0, topPadding: 0)
                .padding(.bottom)
            PaymentButtonView()

        }
        .background(Color(hex: "#111111"))
        .navigationBarBackButtonHidden()
    }
    
}

#Preview {
    TicketDetailsView()
}

struct NavigationHeaderView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Button(action: {
                    coordinator.pop()
                }, label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .frame(width: 12,height: 20)
                        .foregroundStyle(Color.white
                        )
                        .fontWeight(.bold)
                })
                .padding(.trailing,16)
                Text("Payment details")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                ZStack(alignment: .leading){
                    RoundedRectangle(cornerSize: CGSize(width: 50, height: 25))
                        .stroke(Color(hex: "#29B865"), lineWidth:2)
                        .padding(.trailing,16)
                        .padding(.leading,25)
                        .padding(.top,14)
                        .padding(.bottom,14)
                    HStack {
                        Image("Clock")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding(.leading,30)
                        
                        Text("09m:26s")
                            .foregroundColor(Color(hex: "#29B865"))
                            .padding(.trailing,4)
                    }
                }
//                .padding(.leading)
                .frame(width: 155,height: 60)
                .padding(.trailing,4)
//                .padding(.top)
            }
            .padding(.leading,20)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            
            RoundedRectangle(cornerRadius: 0)
                .fill(Color.gray)
                .frame(maxWidth: .infinity, maxHeight: 0.5)
        }
    }
}

struct PaymentButtonView: View {
    var body: some View {
        ZStack {
            Button {
                //
            } label: {
                RoundedRectangle(cornerRadius: 8)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .padding(.horizontal)
                
                    .foregroundStyle(LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(hex: "#EF233C"), location: 0.00),
                            Gradient.Stop(color: Color(hex: "#4224AC"), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: -0.04, y: 0.5),
                        endPoint: UnitPoint(x: 2.17, y: 0.5)
                    ))
            }
            
            Text("Pay ₹2455")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
}

struct PaymentDetailView: View {
//    @State var ticketHeightCons:CGFloat = 350.0
    
    var body: some View {

        if #available(iOS 16.4, *) {
            List {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color(hex: "#222222"))
                    
                    ExtractedView()
                    
                    
                }
                .listRowBackground(Color(hex: "#111111"))
                
                
            }
            .scrollBounceBehavior(.basedOnSize)
            .background(Color(hex: "#111111"))
            .listStyle(.plain)
        } else {
            List {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color(hex: "#222222"))
                    
                    ExtractedView()
                    
                    
                }
                .listRowBackground(Color(hex: "#111111"))
                
                
            }
            .background(Color(hex: "#111111"))
            .listStyle(.plain)
        }
            

    }
}

struct ExtractedView: View {
    
    @State var isDropDownTapped: Bool = false
//    @Binding var ticketHeightCons: CGFloat
    
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Bengaluru")
                        .foregroundColor(Color(hex: "#EEEEEE"))
                        .font(.title3)
                        .fontWeight(.bold)
//                        .padding(.bottom)
                        .padding(.top)
//                        .padding(.bottom)
                    
                    Text("23:56")
                        .foregroundColor(Color(hex: "#EEEEEE"))
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text("23rd Sept, Fri")
                        .foregroundColor(Color(hex: "#888888"))
           
                }
                .padding(.leading,16)
                
                Spacer()
                Image("busRoute")
                    .resizable()
                    .frame(width: 60, height: 40)
                //                .padding(.top,-50)
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Bengaluru")
                        .foregroundColor(Color(hex: "#EEEEEE"))
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.top)
//                        .padding(.bottom)
                        
                    
                    Text("23:56")
                        .foregroundColor(Color(hex: "#EEEEEE"))
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("23rd Sept, Fri")
                        .foregroundColor(Color(hex: "#888888"))
                    
                   
                }
                .padding(.trailing,16)
            }
            .padding(.top)
//            Spacer()
            
            HStack {
                
                Text("Yolo Bus")
                    .foregroundColor(Color(hex: "#888888"))
                    .padding(.leading)
                  
                Spacer()
                
                Text("AC Sleeper (2 + 1)")
                    .foregroundColor(Color(hex: "#888888"))
                    .padding(.trailing)
                   
            }
            .padding(.top)
            Spacer()
            SepratorLine(leading: 0, trailing: 0, topPadding: 10)
            Spacer()
            
            //MARK: - Pasenger detail
            VStack {
                ForEach(0..<2) { index in
                    
                    HStack {
                        Text("Mr. Sushavon Paul")
                            .foregroundColor(Color(hex: "#EEEEEE"))
//                            .font(.title3)
                        Spacer()
                        Text("S25")
                            .foregroundColor(Color(hex: "#EEEEEE"))
//                            .font(.title3)
                    }
                    .padding(.horizontal)
                    .font(.headline)
//                    .padding(.top)
                    
                }
                .padding(.top,4)
            }
            .padding(.top,4)
            Spacer()
            SepratorLine(leading: 0, trailing: 0, topPadding: 16)
            
            //MARK: - Boarding and Droping View
            if isDropDownTapped {
            VStack {
                HStack {
                    Image("boarding&dropingLocation")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 197)
                    .padding(.leading)
                    
                    Spacer()
                    VStack {
                        VStack(alignment:.leading) {
                            Text("Boarding Point")
                                .font(.subheadline)
                                .foregroundColor(Color(hex: "#898A90"))
                                .padding(.bottom,4)
                            Text("Bellandur")
                                .font(.headline)
                                .foregroundColor(Color(hex: "#EEEEEE"))
                            Text("Near Kanti Sweet Shop, -Near kanti sweet shop")
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                                .foregroundColor(Color(hex: "#CCCCCC"))
                        }
                        .padding(.top,16)
                        .padding(.bottom,48)
                        
                        VStack(alignment:.leading) {
                            Text("Boarding Point")
                                .font(.subheadline)
                                .padding(.bottom,4)
                                .foregroundColor(Color(hex: "#898A90"))
                            Text("Koyembedu")
                                .font(.headline)
                                .foregroundColor(Color(hex: "#EEEEEE"))
                            Text("Near Kanti Sweet Shop, -Near kanti sweet shop")
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                                .foregroundColor(Color(hex: "#CCCCCC"))
                        }
                    }
                    .frame(width: 240,alignment: .leading)
                    Spacer()
                }
            }
            .padding(.top)
            
            SepratorLine(leading: 0, trailing: 0, topPadding: 16)
            
            //MARK: - Fare breakout
//            if isDropDownTapped {
                VStack(alignment: .leading) {
                    HStack {
                       Text("Base Fare")
                        Spacer()
                        Text("₹2299.00")
                    }
                    .padding(.bottom,8)
                    .padding(.top,8)
                    HStack {
                       Text("Service Charge")
                        Spacer()
                        Text("₹2299.00")
                    }
                    .padding(.bottom,8)
                    HStack {
                       Text("Bus Partner GST")
                        Spacer()
                        Text("₹2299.00")
                    }
                    .padding(.bottom,8)
                    HStack {
                       Text("Total Amount")
                        Spacer()
                        Text("₹2299.00")
                    }
                    .padding(.bottom,8)
                    
                    DashedLine()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                        .foregroundColor(Color(hex: "#333333"))
                        .frame(height: 1)
                        .padding(.leading, 0)
                        .padding(.trailing, 0)
                        .padding(.top, 0)
                        
                   
                }
                .foregroundColor(Color(hex: "#EEEEEE"))
                .padding(.horizontal)
            }
            
            //MARK: - AMOUNT
            VStack {
                HStack {
                    Text("Total to be paid")
                        .foregroundColor(Color(hex: "#EEEEEE"))
//                        .font(.title3)
                    Spacer()
                    Text("₹2455")
                        .foregroundColor(Color(hex: "#3287FA"))
//                        .font(.title3)
                }
                .font(.title3)
                .fontWeight(.bold)
                .padding(.horizontal)
                .padding(.top)
            }
           
            VStack {
                Spacer()
                Circle()
                       .stroke(lineWidth: 3)
                       .fill(Color(hex: "#333333"))
                       .frame(width: 36, height: 36)
                       .background(Color(hex: "#222222"))
                       .clipShape(Circle())
                       .frame(maxWidth: .infinity, alignment: .bottom)
                       .padding(.bottom, -18)
                       .overlay(
                        Image( isDropDownTapped ? "backward_icon" : "forward_icon")
                               .resizable()
                               .scaledToFit()
                               .frame(width: 24, height: 24,alignment: .center)
                               .padding(.bottom,-18)
                       )
                       .onTapGesture {
                           isDropDownTapped.toggle()

                       }

            }
          
        }
        

    }
}

struct DashedLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}
