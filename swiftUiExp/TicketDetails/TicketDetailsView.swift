//
//  TicketDetailsView.swift
//  swiftUiExp
//
//  Created by Sagar on 19/06/24.
//

import SwiftUI

struct TicketDetailsView: View {
    
    var body: some View {
//        GeometryReader { geomatery in
//        Group {
            ExtractedView()
//        }
            
        }

//    }
}

#Preview {
    TicketDetailsView()
}

struct ExtractedView: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Button(action: {
                    //
                }, label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .frame(width: 12,height: 20)
                        .foregroundStyle(Color.black
                        )
                        .fontWeight(.bold)
                })
                .padding(.trailing,16)
                Text("Payment details")
                    .font(.title2)
                    .fontWeight(.bold)
                
                ZStack(alignment: .leading){
                    RoundedRectangle(cornerSize: CGSize(width: 60, height: 25))
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
                    }
                }
                .padding(.leading)
            }
            .padding(.leading,20)
            .frame(maxWidth: .infinity)
            .frame(height: 60)
        }
    }
}
