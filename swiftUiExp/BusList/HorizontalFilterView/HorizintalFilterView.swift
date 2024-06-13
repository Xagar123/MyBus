//
//  HorizintalFilterView.swift
//  swiftUiExp
//
//  Created by Sagar on 07/06/24.
//

import Foundation
import SwiftUI

//struct CustomFilterView: View {
//    
//    let rows:[GridItem] = [
//        GridItem(.fixed(40))
//    ]
//    
//    var filterItems: [(image: FilterImage, text: String)] = [
//           (.sort_by,"Sort by"),
//           (.ac,"AC"),
//           (.non_ac,"Non AC"),
//           (.single,"Single"),
//           (.sleeper,"Sleeper")
//       ]
//    
//    var body: some View {
//            HStack(alignment: .top, spacing: 0) {
//                ScrollView(.horizontal) {
//                    LazyHGrid(rows: rows, spacing: 8) {
//                        ForEach(filterItems, id: \.image) { item in
//                            ZStack {
//                                RoundedRectangle(cornerRadius: 40)
//                                    .fill(Color.clear)
//                                    .frame(height: 40)
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 40)
//                                            .stroke(Color(hex: "#333333"), lineWidth: 1)
//                                    )
//                                    
//                                HStack {
//                                    Image(item.image.rawValue)
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                        .frame(width: 20, height: 20,alignment: .leading)
////                                        .background()
//                                        .padding(.leading,-4)
////                                        .padding()
//                                    Text(item.text)
//                                        .foregroundColor(.white)
//                                }
//                                .padding()
//                            }
//                            .onTapGesture {
//                                if item.text == "Sort by" {
//                                    print("hi")
//                                }
//                            }
//                        }
//                        .padding(.leading, 1)
//                    }
//                }
//                .scrollIndicators(.hidden)
//                .frame(height: 40)
//            }
//        }
//}
    
//MARK: - Filter View
struct HorizintalFilterView: View {
    
    @ObservedObject var viewModel = FilterViewModel()
    
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
                                            .stroke(item.isSelected ? (item.text == "Sort by" ? Color.white : Color(hex: "#333333")) : Color(hex: "#333333") , lineWidth: 1)
                                    )
                                    
                                HStack {
                                    Image(item.image.rawValue)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20,alignment: .leading)
//                                        .background()
                                        .padding(.leading,-4)
//                                        .padding()
                                    Text(item.text)
                                        .foregroundColor(item.isSelected ? (item.text == "Sort by" ? Color.white : Color.black) : Color.white)
                                }
                                .padding()
                            }
                            .onTapGesture {
//                                if item.text == "Sort by" {
//                                    print("hi")
//                                }
                                viewModel.performAction(for: item)
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
    

