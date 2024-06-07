//
//  SortByView.swift
//  swiftUiExp
//
//  Created by Shubam Vijay Yeme on 06/06/24.
//

import SwiftUI

struct SortByView: View {
    
    @State var listTextSelect: String = "All"
    var body: some View {
       RoundedRectangle(cornerRadius: 20)
            .fill(Color(hex: "#222222"))
            .frame(height: 408)
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .overlay {
                VStack(){
                    
                    SortByList(sortText: "All", onTexttap: $listTextSelect)
                    Spacer(minLength: 20)
                    SortByList(sortText: "Top Rated", onTexttap: $listTextSelect)
                    Spacer(minLength: 20)
                    SortByList(sortText: "Price: Cheapest", onTexttap: $listTextSelect)
                    Spacer(minLength: 20)
                    SortByList(sortText: "Price: Expensive", onTexttap: $listTextSelect)
                    Spacer(minLength: 20)
                    SortByList(sortText: "Availability: High to Low", onTexttap: $listTextSelect)
                    Spacer(minLength: 20)
                    SortByList(sortText: "Departure: Early", onTexttap: $listTextSelect)
                    Spacer(minLength: 20)
                    SortByList(sortText: "Departure: Late", onTexttap: $listTextSelect)
                    
                }.padding(.vertical, 20)
            }
       
    }
}

#Preview {
    SortByView()
}

struct SortByList: View {
    var sortText : String
    @Binding var onTexttap: String
    var body: some View {
        HStack(){
            Image(systemName: sortText == onTexttap ? "record.circle" : "circle")
                .foregroundColor(Color(hex: sortText == onTexttap ? "#EF233C" : "#888888"))
            Text(sortText)
                .foregroundStyle(Color.white)
                .font(.system(size: 16))
                .padding(.leading,12 )
            Spacer()
        }.padding(.leading, 40)
            .onTapGesture {
                withAnimation(.easeInOut.speed(0.8)) {
                    onTexttap = sortText
                }
            }
    }
}
