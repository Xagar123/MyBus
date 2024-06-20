//
//  Session Expired.swift
//  iOS_BUS
//
//  Created by Soma Prabha R on 13/06/24.
//

import SwiftUI

struct Session_Expired: View {
    var body: some View {
        VStack(alignment: .center) {
        Image("Session expired")
               
                .frame(width: 268,height: 134)
                .padding()
            Button("Okay") {
                
            }
          
            .frame(width: 140,height: 48)
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(8)
        }
       
     
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
    Session_Expired()
}
