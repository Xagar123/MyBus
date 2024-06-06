//
//  Empty Screen.swift
//  POC2
//
//  Created by Sagar on 06/06/24.
//

import Foundation
import SwiftUI

struct EmptyBusListView: View {
    
    var body: some View {
            VStack(alignment: .center) {
                Image("emptyRouat")
                
                Text("No buses found")
                    .padding(.top, 32)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Please try selecting a different route for your journey")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding()
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                
                Button(action: {
                    // Your action here
                }) {
                    Text("Edit Search")
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .font(.headline)
                        .cornerRadius(8)
                        .shadow(radius: 2)
                }
                .padding(.top, 40)
                .padding(.horizontal, 16) // Ensure the button is padded horizontally
                
                Spacer()
            }
            .padding(.horizontal, 16)
//            .padding(.bottom,100)
        }
}
