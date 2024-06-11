//
//  HorizintalFilterView.swift
//  swiftUiExp
//
//  Created by Sagar on 07/06/24.
//

import Foundation
import SwiftUI

//MARK: - Filter View
struct HorizintalFilterView: View {
    
    @ObservedObject var busViewModel : BusServiceViewModel
    @Binding var shortByTapped: Bool
    
    @StateObject var viewModel = FilterViewModel()
    
    let rows:[GridItem] = [
        GridItem(.flexible())
    ]
    
    var body: some View {
            HStack(alignment: .top, spacing: 0) {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows, spacing: 8) {
                        ForEach(viewModel.filterItems , id: \.image) { item in
                            ZStack {
                                RoundedRectangle(cornerRadius: 40)
                                    .fill(item.isSelected ? (item.text == "Sort by" ? Color.clear : Color.white) : Color.clear)
                                    .frame(height: 40)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 40)
                                            .stroke((item.text == "Sort by" && shortByTapped ? Color.white : Color(hex: "#333333")) , lineWidth: 1)
                                    )
                                    
                                HStack {
                                    Image(item.image.rawValue)
                                        .renderingMode(.template)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20,alignment: .leading)
//                                        .background()
                                        .padding(.leading,-4)
//                                        .padding()
                                    Text(item.text)
                                        
                                }
                                .foregroundColor(item.isSelected ? (item.text == "Sort by" ? Color.white : Color.black) : Color.white)
                                .padding()
                            }
                            .onTapGesture {
//                                if item.text == "Sort by" {
//                                    print("hi")
//                                }
                                
                                
                                if item.text == "Sort by"{
                                    withAnimation(.easeInOut.speed(0.9)) {
                                        shortByTapped.toggle()
                                    }
                                } else {
                                    viewModel.performAction(for: item, viewModel: self.busViewModel)
                                }
                            }
                        }
                        .padding(.leading, 1)
                    }
                }
                .scrollIndicators(.hidden)
                .frame(height: 40)
            }
            .padding(.horizontal,16)
        }
}
    

