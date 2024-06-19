//
//  SeatLayoutNotAvailable.swift
//  iOS_BUS
//
//  Created by Soma Prabha R on 11/06/24.
//

import SwiftUI

struct SeatLayoutNotAvailable: View {
    var body: some View {
        VStack(alignment: .center) {
        Image("Frame 2393")
                .padding()
            Button("Okay") {
                
            }
          
            .frame(width: 140,height: 48)
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(8)
        }
        .frame(width: 300,height: 280)
        .padding(.all,16)
        .background(Color(hex:"#222222"))
        .cornerRadius(16)
        .overlay(
           
                    RoundedRectangle(cornerRadius: 16)
                     
                        .stroke(Color(hex:"#333333"), lineWidth: 1)
                )
      
    }
}

#Preview {
    SeatLayoutNotAvailable()
}
