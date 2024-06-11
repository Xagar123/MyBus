//
//  SortByView.swift
//  swiftUiExp
//
//  Created by Shubam Vijay Yeme on 06/06/24.
//

import SwiftUI

struct SortByView: View {
    
    @ObservedObject var viewModel : BusServiceViewModel
    
//    @State var listTextSelect: SortBy = .all
    @Binding var onTapRemove: Bool
    var body: some View {
       RoundedRectangle(cornerRadius: 20)
            .fill(Color(hex: "#222222"))
            .frame(height: 408)
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .overlay {
                VStack(){
                    
                    SortByList(viewModel: self.viewModel, sortText: "All", onTapRemove: $onTapRemove)
                    Spacer(minLength: 20)
                    SortByList(viewModel: self.viewModel, sortText: "Top rated", onTapRemove: $onTapRemove)
                    Spacer(minLength: 20)
                    SortByList(viewModel: self.viewModel, sortText: "Price: Cheapest", onTapRemove: $onTapRemove)
                    Spacer(minLength: 20)
                    SortByList(viewModel: self.viewModel, sortText: "Price: Expensive", onTapRemove: $onTapRemove)
                    Spacer(minLength: 20)
                    SortByList(viewModel: self.viewModel, sortText: "Availability: Low to High", onTapRemove: $onTapRemove)
                    Spacer(minLength: 20)
                    SortByList(viewModel: self.viewModel, sortText: "Availability: High to Low", onTapRemove: $onTapRemove)
                    Spacer(minLength: 20)
                    SortByList(viewModel: self.viewModel, sortText: "Departure: Early", onTapRemove: $onTapRemove)
                    Spacer(minLength: 20)
                    SortByList(viewModel: self.viewModel, sortText: "Departure: Late", onTapRemove: $onTapRemove)
                    
                }.padding(.vertical, 20)
            }
       
    }
}

//#Preview {
//    SortByView()
//}

struct SortByList: View {
    
    @ObservedObject var viewModel : BusServiceViewModel
    
    var sortText : String
//    @Binding var onTexttap: SortBy
    @Binding var onTapRemove: Bool
    var body: some View {
        HStack(){
            Image(systemName: sortText == viewModel.sortBySelected.rawValue ? "record.circle" : "circle")
                .foregroundColor(Color(hex: sortText == viewModel.sortBySelected.rawValue ? "#EF233C" : "#888888"))
            Text(sortText)
                .foregroundStyle(Color.white)
                .font(.system(size: 16))
                .padding(.leading,12 )
            Spacer()
        }.padding(.leading, 40)
            .onTapGesture {
                withAnimation(.easeInOut.speed(0.6)) {
                    viewModel.sortBySelected = mapSortTextToSortBy(sortText)
                    onTapRemove.toggle()
                    print(viewModel.sortBySelected.rawValue)
                }
            }
    }
    
    private func mapSortTextToSortBy(_ text: String) -> SortBy {
        return SortBy(rawValue: text) ?? .all
    }
}
