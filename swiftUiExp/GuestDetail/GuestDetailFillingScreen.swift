//
//  GuestDetailFillingScreen.swift
//  swiftUiExp
//
//  Created by Shubam Vijay Yeme on 25/06/24.
//

import SwiftUI

struct GuestDetailFillingScreen: View {
    @State var fullName: String = ""
    @State var age: String = ""
    var body: some View {
        VStack{
            ScrollView{
                TopheadingView()
                SepratorLine(leading: 0, trailing: 0, topPadding: 16)
                genderView()
                textFieldView(fullName: $fullName, age: $age)
                HStack{
                    Image(systemName: "square")
                        .foregroundStyle(Color(hex: "#888888"))
                    Text("Save this guest for faster checkout later")
                        .font(.regular(size: 14))
                        .foregroundStyle(Color(hex: "#EEEEEE"))
                    Spacer()
                }.padding(.leading,16)
            }
            RoundedRectangle(cornerRadius: 8)
                .frame(height: 48)
                .foregroundStyle(Color(hex: "#FEFEFE"))
                .padding(.horizontal,16)
                .overlay {
                    Text("Add traveller")
                        .font(.semiBold(size: 16))
                }
        
        }.background(Color(hex: "#222222"))
            
    }
}

#Preview {
    GuestDetailFillingScreen()
}

struct TopheadingView: View {
    var body: some View {
        HStack {
            Text("Add traveller")
                .font(.bold(size: 20))
                .foregroundStyle(Color.white)
            Spacer()
            Image(systemName: "person")
        }.padding(.horizontal,16)
    }
}

struct genderView: View {
    var body: some View {
        HStack{
            RoundedRectangle(cornerRadius: 40)
                .frame(width: 55,height: 32)
                .foregroundStyle(Color(hex: "#181818"))
                .overlay {
                    RoundedRectangle(cornerRadius: 40).stroke(lineWidth: 1).foregroundStyle(Color(hex: "#333333"))
                    Text("Mr.")
                        .font(.medium(size: 14))
                        .foregroundStyle(Color.white)
                }
            RoundedRectangle(cornerRadius: 40)
                .frame(width: 55,height: 32)
                .foregroundStyle(Color(hex: "#181818"))
                .overlay {
                    RoundedRectangle(cornerRadius: 40).stroke(lineWidth: 1).foregroundStyle(Color(hex: "#333333"))
                    Text("Ms.")
                        .font(.medium(size: 14))
                        .foregroundStyle(Color.white)
                }
            Spacer()
        }.padding(.leading,16)
    }
}

struct textFieldView: View {
    @Binding var fullName: String
    @Binding var age: String
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 56)
                .foregroundStyle(Color(hex: "#181818"))
                .overlay {
                    RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1)
                        .foregroundStyle(Color(hex: "#333333"))
                        .overlay {
                            TextField("", text: $fullName, prompt: Text("Full name").foregroundColor(Color(hex: "#888888")).font(.regular(size: 16)))
                                .foregroundStyle(Color.white)
                                .font(.regular(size: 16))
                                .padding(.leading,16)
                        }
                    
                }
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 56)
                .foregroundStyle(Color(hex: "#181818"))
                .overlay {
                    RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1)
                        .foregroundStyle(Color(hex: "#333333"))
                        .overlay {
                            TextField("", text: $age, prompt: Text("Age").foregroundColor(Color(hex: "#888888")).font(.regular(size: 16)))
                                .foregroundStyle(Color.white)
                                .keyboardType(.numberPad)
                                .font(.regular(size: 16))
                                .padding(.leading,16)
                        }
                    
                }
        }.padding(.horizontal,16)
    }
}
