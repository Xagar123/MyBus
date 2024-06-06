//
//  ComboSlide.swift
//  swiftUiExp
//
//  Created by Shubam Vijay Yeme on 30/05/24.
//

import SwiftUI


    struct ComboSlide: View {
        
        @State var inactiveColor:Color = Color(hex: "#464646") // Background of Slider
        @State var activeColor:Color = .white // Active portion of Slider
        
        @State var barheight:CGFloat = 10 // Slider Bar Height
        @State var buttonDiameter:CGFloat = 28 // Slider Button Diameter
        
        @State var pos1:CGFloat = 0.0
        @State var pos2:CGFloat = 1.0
        @State var minimumPrice: String = "500"
        @State var maximumPrice: String = "5000"
        var widthFactor:CGFloat { return pos2 - pos1 } // Factor for how wide the overlay is
        
        var body: some View {
            VStack{
                GeometryReader { geometry in
                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(self.inactiveColor)
                            .frame(width: nil, height: self.barheight, alignment: .center)
                        
                        // Active Overlay here
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(self.activeColor)
                            .frame(width: geometry.size.width  * self.widthFactor, height: self.barheight, alignment: .center)
                            .position(x: geometry.size.width * (self.pos1 + (self.widthFactor/2.0)), y: geometry.size.height/2.0)
                        
                        
                        // Buttons here
                        Circle()
                            .foregroundColor(Color(hex: "#222222"))
                            .frame(width: self.buttonDiameter, height: self.buttonDiameter, alignment: .center)
                            .overlay(content: {
                                Circle().stroke(Color(uiColor: .white), lineWidth: 3)
                                
                                    .overlay(content: {
                                        
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 5)
                                                .rotation(.degrees(45))
                                                .foregroundStyle(Color.white)
                                                .frame(width: 20, height: 20)
                                                .offset(x: pos2 - pos1 < 0.2 ? -14 : 0, y: -35)
                                            
                                            RoundedRectangle(cornerRadius: 40)
                                                .frame(width: 70, height: 28)
                                                .foregroundColor(Color.white)
                                                .overlay (alignment: .center){
                                                    Text("₹ \(av(pos: pos1))")
                                                        .foregroundStyle(Color(hex: "#111111"))
                                                }.offset(x: pos2 - pos1 < 0.2 ? -27 : 0, y: -45)
                                        }
                                    })
                            })
                            .position(x: geometry.size.width * self.pos1, y: geometry.size.height/2.0)
                            .gesture(DragGesture()
                                .onChanged({ value in
                                    // Caluclate the scaled position
                                    let newPos = value.location.x / geometry.size.width
                                    
                                    // Set new Position
                                    if newPos < 0 { self.pos1 = 0 }
                                    else if newPos > self.pos2 { self.pos1 = self.pos2 - 0.01 }
                                    else { self.pos1 = newPos }
                                    minimumPrice = av(pos: pos1)
                                })
                            )
                        
                        
                        Circle()
                            .foregroundColor(Color(hex: "#222222"))
                            .frame(width: self.buttonDiameter, height: self.buttonDiameter, alignment: .center)
                            .overlay(content: {
                                Circle().stroke(Color(uiColor: .white), lineWidth: 3)
                                    .overlay(content: {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 5)
                                                .rotation(.degrees(45))
                                                .foregroundStyle(Color.white)
                                                .frame(width: 20, height: 20)
                                                .offset(x: pos2 - pos1 < 0.2 ? 14 : 0, y: -35)
                                                
                                            RoundedRectangle(cornerRadius: 40)
                                                .frame(width: 70, height: 28)
                                                .foregroundStyle(Color.white)
                                                .overlay (alignment: .center){
                                                    Text("₹ \(av(pos:pos2))")
                                                        .foregroundStyle(Color(hex: "#111111"))
                                                }.offset(x: pos2 - pos1 < 0.2 ? 27 : 0, y: -45)
                                        }
                                       
                                    })
                            })
                            .position(x: geometry.size.width * self.pos2, y: geometry.size.height/2.0)
                            .gesture(DragGesture()
                                .onChanged({ value in
                                    // Caluclate the scaled position
                                    let newPos = value.location.x / geometry.size.width
                                    
                                    // Set new Position
                                    if newPos > 1.0 { self.pos2 = 1.0 }
                                    else if newPos < self.pos1 { self.pos2 = self.pos1 + 0.01 }
                                    else { self.pos2 = newPos }
                                    maximumPrice = av(pos:pos2)
                                })
                            )
                    }
                    
                }.padding(.horizontal, 58)
                HStack {
                    BudgetRangeView1(topTitle: "Minimum", bottomTitle: "₹", price: $minimumPrice) {
                        pos1 = convertMinPriceToPos(price: minimumPrice, maxPrice: maximumPrice, posTwo: pos2)
                    }
                    Rectangle()
                        .frame(width: 20, height: 2)
                        .foregroundColor(Color(hex: "#333333"))
                    BudgetRangeView1(topTitle: "Maximum", bottomTitle: "₹", price: $maximumPrice) {
                        pos2 = convertMaxPriceToPos(price: maximumPrice, minPrice: minimumPrice, posOne: pos1)
                    }
                }.padding(.top,30)
            }.padding(.top,50)
        }
    }
    
    func av(pos: CGFloat) -> String{
        return "\(Int(pos * 4500)+500)"
    }
    
    
func convertMinPriceToPos(price: String, maxPrice: String, posTwo: CGFloat) -> CGFloat {
        if Int(price) ?? 500 < 500 {
            return CGFloat(0.0)
        }else if Int(price) ?? 500 >= Int(maxPrice) ?? 500{
            return posTwo
        }
        else{
            return CGFloat((Double(Int(price) ?? 500) - 500) / 4500.0)
        }
    }

func convertMaxPriceToPos(price: String, minPrice: String, posOne: CGFloat) -> CGFloat {
       
        if Int(price) ?? 500 > 5000{
            return CGFloat(1.0)
        }else if Int(price) ?? 500 <= Int(minPrice) ?? 500{
            return posOne
        }
        else{
            return CGFloat((Double(Int(price) ?? 500) - 500) / 4500.0)
        }
        
    }
    
    struct BudgetRangeView1: View {
        var topTitle: String
        var bottomTitle: String
        @Binding var price: String
        
        var callBack: () -> Void
        
        @FocusState var focus: Bool
        
        var body: some View {
            
            RoundedRectangle(cornerRadius: 8)
                .frame(height: 65)
                .foregroundColor(Color(hex: "#181818"))
                .overlay() {
                    RoundedRectangle(cornerRadius: 8).stroke(Color(hex: focus ? "#EEEEEE" : "#222222"), lineWidth: 1)
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
                                            callBack()
                                        }
                                        .onSubmit {
                                            callBack()
                                        }
                                        .focused($focus)
                                    
                                }
                            }.padding(.leading,20)
                        }
                }.padding(.horizontal,20)
                .onTapGesture {
                    focus = true
                }
        }
    }
    
    
    let c1 = Color.gray
    let c2 = Color.green
    var pos1:CGFloat = 0.2
    var pos2:CGFloat = 0.9
    
    
//    #Preview {
//        VStack{
//            ComboSlide()
//        }
//    }
    

