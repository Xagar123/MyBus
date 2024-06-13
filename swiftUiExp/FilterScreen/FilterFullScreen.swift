//
//  ContentView.swift
//  swiftUiExp
//
//  Created by Shubam Vijay Yeme on 27/05/24.
//

import SwiftUI

struct FilterFullScreen: View {
    @State var minimunPrice: String = "500"
    @State var maximumPrice: String = "5000"
    @State var minimumPosition: CGFloat = 0.0
    @State var maximumPosition: CGFloat = 1.0
    @StateObject var viewModel = BusServiceViewModel()
    var isIncoming = true
    var body: some View {
        
        ZStack(alignment: .leading){
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "#222222"))
                .ignoresSafeArea()
            
            VStack(spacing: 0){
                topTitleBarHandling()
                SepratorLine(leading: 0, trailing: 0, topPadding: 10)
                ScrollView{
                    filterSectionHeader(title: "Bus Type")
                    busTypeHandling()
                    SepratorLine(leading: 16, trailing: 16, topPadding: 26)
                    filterSectionHeader(title: "Budget")
                    ComboSlide()
                    SepratorLine(leading: 16, trailing: 16, topPadding: 26)
                    filterSectionHeader(title: "Single Seat")
                    SingleSeatView(singleSeatTap: false)
                    SepratorLine(leading: 16, trailing: 16, topPadding: 26)
                    filterSectionHeader(title: "Bus Partner & Location")
                    busPartnerAndLocationHandling()
                    SepratorLine(leading: 16, trailing: 16, topPadding: 26)
                    filterSectionHeader(title: "Departure Time")
                    departureTimeHandling()
                }
                SepratorLine(leading: 0, trailing:0, topPadding: 0)
                Rectangle()
                    .fill(Color(hex: "#222222"))
                    .frame(height: 80)
                    .overlay {
                        HStack{
                            Text("Clear all")
                                .font(.system(size: 14))
                                .foregroundColor(Color.white)
                                .underline()
                            Spacer()
                            RoundedRectangle(cornerRadius: 120)
                                .fill(Color.white)
                                .frame(width: 175,height: 48)
                                .overlay {
                                    Text("Show 200 buses")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(Color(hex: "#111111"))
                                }
                            
                        }.padding(.horizontal, 20)
                    }   
            }
        }.padding(.top, 10)
            .onTapGesture {
                hideKeyboard()
            }
    }
}


struct busTypeFilterView: View {
    var title: String
    var image: String
    @State var tapOnBusType: Bool
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .frame(height: 77)

            .foregroundColor(tapOnBusType ? Color(hex: "#333333") : Color(hex: "#222222"))
            .onTapGesture {
                
                withAnimation(.easeInOut.speed(0.4)) {
                    tapOnBusType.toggle()
                }
                
            }
            .overlay() {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(tapOnBusType ? Color(hex: "#FEFEFE") : Color(hex: "#464646"), lineWidth: 1)
                    .overlay(alignment: .leading) {
                        VStack(alignment: .leading){
                            Image(systemName: image)
                                .foregroundColor(Color.white)
                            Text(title)
                                .font(.system(size: 14))
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.leading)
                                .padding(.top, 5)
                        }.padding(.leading,10)
                    }
            }
    }
}



struct BudgetRangeView: View {
    var topTitle: String
    var bottomTitle: String
    @Binding var price: String
    
    @Binding var pos: CGFloat
    var body: some View {
        
        RoundedRectangle(cornerRadius: 8)
            .frame(height: 65)
            .foregroundColor(Color(hex: "#181818"))
            .overlay() {
                RoundedRectangle(cornerRadius: 8).stroke(Color(hex: "#EEEEEE"), lineWidth: 1)
                    .overlay(alignment: .leading) {
                        VStack(alignment: .leading){
                            Text(topTitle)
                                .foregroundColor(Color(hex: "#888888"))
                                .font(.system(size: 12))
                                .padding(.top,5)
                            HStack{
                                Text(bottomTitle)
                                    .font(.system(size: 16))
                                    .foregroundColor(Color.white)
                                    .multilineTextAlignment(.leading)
                                    .padding(.top, 5)
                                TextField("", text: $price)
                                    .keyboardType(.numberPad)
                                    .foregroundColor(.white)
                                    .background(Color.clear)
                                    .onChange(of: price) { oldValue, newValue in
                                        let value = (Int(newValue) ?? 500) - 500
                                        pos = CGFloat( value / 4500)
                                    }
                                    
                                    
                            }
                        }.padding(.leading,20)
                    }
            }.padding(.horizontal,20)
    }
}


struct DepartureTimeView: View {
    var title: String
    var image: String
     @State var departureViewTap: Bool
    var body: some View {
        ZStack(){
            RoundedRectangle(cornerRadius: 8)
                .frame(height: 120)
                .foregroundColor(departureViewTap ? Color(hex: "#333333") : Color(hex: "#222222"))
                .onTapGesture {
                    withAnimation(.easeInOut.speed(0.4)) {
                        departureViewTap.toggle()
                    }
                }
                .overlay() {
                    RoundedRectangle(cornerRadius: 8).stroke(departureViewTap ? Color(hex: "#FEFEFE") : Color(hex: "#464646"), lineWidth: 1)
                        .overlay(alignment: .center) {
                            VStack{
                                Image(systemName: image)
                                    .resizable()
                                    .frame(width:25, height: 25)
                                    .foregroundColor(Color.white)
                                Text(title)
                                    .font(.system(size: 14))
                                    .foregroundColor(Color.white)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 10)
                                
                            }
                        }
                }
        }
    }
}

struct BusPartnerView: View {
    var title: String
    var image: String
    var body: some View {
            RoundedRectangle(cornerRadius: 8)
            .fill(Color(hex: "#181818"))
                .frame(height: 56)
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .overlay {
                    RoundedRectangle(cornerRadius: 8).stroke(Color(hex: "#333333"), lineWidth: 1)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                    HStack{
                        Text(title)
                            .foregroundColor(Color.white)
                        Spacer()
                        Image(systemName: image)
                            .foregroundColor(Color.white)
                        
                    }.padding(.horizontal, 35)
                }
           
        
    }
}




extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}



struct SingleSeatView: View {
     @State var singleSeatTap: Bool
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(singleSeatTap ? Color(hex: "#333333") : Color(hex: "#222222"))
                .frame(height: 64)
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .onTapGesture {
                    withAnimation(.easeInOut.speed(0.4)) {
                        singleSeatTap.toggle()
                    }
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 8).stroke(singleSeatTap ? Color(hex: "#FEFEFE") : Color(hex: "#464646"), lineWidth: 1)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                        .overlay {
                            HStack{
                                Image(systemName: "carseat.right.fill")
                                    .foregroundColor(Color.white)
                                Text("Single Seat")
                                    .foregroundColor(Color.white)
                            }
                        }
                }
        }.padding(.top,10)
    }
}

struct busTypeHandling: View {
    var body: some View {
        VStack(spacing:  20) {
            
            HStack(){
                busTypeFilterView(title: "AC", image: "air.conditioner.horizontal.fill", tapOnBusType: false)
                Spacer(minLength: 12)
                busTypeFilterView(title: "Non AC", image: "air.purifier.fill", tapOnBusType: false)
                Spacer(minLength: 12)
                busTypeFilterView(title: "Seater", image: "carseat.right.fill", tapOnBusType: false)
            }
            
            HStack(){
                busTypeFilterView(title: "Sleeper", image: "bed.double.fill", tapOnBusType: false)
                Spacer(minLength: 12)
                busTypeFilterView(title: "Price Drop", image: "dollarsign.arrow.circlepath", tapOnBusType: false)
                Spacer(minLength: 12)
                busTypeFilterView(title: "Live Traking", image: "mappin.and.ellipse", tapOnBusType: false)
            }
            
        }
        .padding(.horizontal, 16)
        .padding(.top, 6)
    }
}

struct filterSectionHeader: View {
    var title: String
    var body: some View {
        HStack{
            Text(title)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color.white)
                .padding(.leading,10)
                .padding(.top,20)
            Spacer()
        }
    }
}

struct SepratorLine: View {
    var leading: Double
    var trailing: Double
    var topPadding: Double
    var body: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(Color(hex: "#333333"))
            .padding(.leading, leading)
            .padding(.trailing, trailing)
            .padding(.top,topPadding)
    }
}

struct topTitleBarHandling: View {
    var body: some View {
        HStack(alignment: .center){
            Text("Filter")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color.white)
                .padding(.leading,10)
                
            Spacer()
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 15,height: 15)
                .foregroundColor(Color(hex: "#888888"))
                .padding(.trailing,20)
                
        }.padding(.top,25)
    }
}

struct departureTimeHandling: View {
    var body: some View {
        HStack(){
            DepartureTimeView(title: "Before\n10 AM", image: "sun.horizon", departureViewTap: false)
            Spacer(minLength: 12)
            DepartureTimeView(title: "10 AM\nTo\n5 PM", image: "sun.max.fill", departureViewTap: false)
            Spacer(minLength: 12)
            DepartureTimeView(title: "5 PM\nTo\n11 PM", image: "sun.haze", departureViewTap: false)
            Spacer(minLength: 12)
            DepartureTimeView(title: "After\n11 PM", image: "moon", departureViewTap: false)
        }
        .padding(.horizontal,16)
        .padding(.bottom,30)
        .padding(.top,10)
    }
}

struct busPartnerAndLocationHandling: View {
    var body: some View {
        VStack{
            BusPartnerView(title: "Bus Partner", image: "bus.fill")
            BusPartnerView(title: "Boarding Point", image: "mappin.and.ellipse")
            BusPartnerView(title: "Dropping Point", image: "mappin.and.ellipse")
        }.padding(.top,10)
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    FilterFullScreen()
}


