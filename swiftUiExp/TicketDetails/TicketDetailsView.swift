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
    var body: some View {
        VStack {
            ScrollView {
                ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 350)
                        .foregroundColor(Color(hex: "#222222"))

                        ExtractedView()
                      

                }
                .padding(.horizontal)
            }
        }
    }
}

struct ExtractedView: View {
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
//                       .padding(.bottom, -18)
                       .overlay(
                           Image("forward_icon")
                               .resizable()
                               .scaledToFit()
                               .frame(width: 24, height: 24,alignment: .center)
//                               .padding(.bottom,-18)
                       )

               
            }
          
        }
        

    }
}
