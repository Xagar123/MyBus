//
//  GoingBackBeforePayment.swift
//  iOS_BUS
//
//  Created by Soma Prabha R on 13/06/24.
//

import SwiftUI

struct GoingBackBeforePayment: View {
    @State private var showSheet = false
    var body: some View {
        Button("Show Sheet") {
            showSheet = true
        }
        .sheet(isPresented: $showSheet) {
          
            HStack{
              
                Spacer()
                    .padding()
                Button("", systemImage: "multiply") {
                    
                }
                
                .frame(width: 24,height: 24)
                .foregroundColor(Color(hex: "#888888"))
            }
        Spacer()
            VStack {
                Image("Frame 2370")
                Spacer()
                Button("Continue") {
                    
                }
                .foregroundColor(Color(hex:"#111111"))
                .fontWeight(.bold)
                .frame(width: 328,height: 48)
                .background(Color(hex: "#FEFEFE"))
                .cornerRadius(8)
                .padding(12)
                Button("Go Back") {
                    
                }
                .foregroundColor(Color(hex: "#F2503F"))
                
            }
            .presentationDetents([.height(300)])
            .presentationDragIndicator(.hidden)
        }
    }
      
    }


#Preview {
    GoingBackBeforePayment()
}
