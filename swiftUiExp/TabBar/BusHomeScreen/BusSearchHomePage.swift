//
//  BusSearchHomePage.swift
//  swiftUiExp
//
//  Created by Sagar on 26/06/24.
//

import Foundation
import SwiftUI

struct BusSearchHomePage: View {
    @EnvironmentObject var busvm: BusServiceViewModel
    var body: some View {
        ZStack{
            Color.black
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    ZStack(alignment: .top) {
                        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                            .frame(height: 410)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(hex: "#333333"), lineWidth: 2)
                            )
                        HomePageSearchCard()
                    }
                    .foregroundColor(Color(hex: "#222222"))
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .padding(.top, 10)
                    HomePageAnimationView()
                }
            }
            .padding(.top, 40)
        }
        .background(Color.black)
        .onAppear(perform: {
            busvm.busServices = []
            busvm.sortedBusServices = []
        })
    }
}

struct HomePageSearchCard: View {
    var body: some View {
        VStack{
            VStack(spacing: 0){
                LeavingFromView()
                LeavingFromGoingToSeparator()
                GoingToView()
            }
            .padding(.top, 10)
            .padding(.leading, 6)
            CommonMethods().separator()
                .padding(.top, 16)
                .padding(.bottom, 14)
            CalendarView()
            CommonMethods().separator()
                .padding(.top, 14)
                .padding(.bottom, 16)
                .foregroundColor(Color(hex: "#222222"))
            QuickTypeDatesView()
            SearchButton()
        }
        .padding()
        .foregroundColor(.white)
    }
}

struct SearchButton: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var busvm: BusServiceViewModel
    var body: some View {
        Button(action: {
            busvm.availableBusService(source: 3, destination: 5, date: "2024-06-28")
            coordinator.navigateToScreen(.SearchResultBusList)
        }) {
            Text("Search")
                .padding()
                .font(
                    Font.custom("Metropolis", size: 16)
                        .weight(.semibold)
                )
                .foregroundColor(Color(red: 1, green: 1, blue: 1))
                .frame(maxWidth: .infinity, alignment: .center)
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(hex: "#EF233C"), location: 0.00),
                            Gradient.Stop(color: Color(hex: "#4224AC"), location: 1.00)
                        ],
                        startPoint: UnitPoint(x: -0.04, y: 0.5),
                        endPoint: UnitPoint(x: 2.17, y: 0.5)
                    )
                )
                .cornerRadius(8)
        }
        .padding(.top, 16)
    }
}

struct LeavingFromView: View {
    var body: some View {
        HStack {
            Image("Send", bundle: Bundle(identifier: "com.multiverse.iOS-BUS"))
                .frame(width: 24, height: 24)
                .frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(100)
                .overlay(
                    RoundedRectangle(cornerRadius: 100)
                        .inset(by: 0.5)
                        .stroke(Color(red: 0.2, green: 0.2, blue: 0.2), lineWidth: 1)
                )
                .padding(.trailing, 10)
            Button {
            } label: {
                Text("Leaving from")
                    .font(
                        Font.custom("Metropolis", size: 18)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8))
            }
            Spacer()
        }
    }
}

struct LeavingFromGoingToSeparator: View {
    var body: some View {
        HStack{
            Image("Vector", bundle: Bundle(identifier: "com.multiverse.iOS-BUS"))
                .resizable()
                .frame(width: 1, height: 30)
                .offset(y: 0)
                .padding(.leading, 18)
                .padding(.trailing, 12)
            Spacer()
            ZStack(alignment: .trailing){
                CommonMethods().separator()
                    .frame(height: 1)
                    .foregroundColor(Color(hex: "#333333"))
                    .padding()
                Image("switchButtonIcon", bundle: Bundle(identifier: "com.multiverse.iOS-BUS"))
                    .resizable()
                    .frame(width: 48, height: 48)
                    .padding(.trailing, 44)
                    .padding(.top, -13)
                    .padding(.bottom, -13)
            }
            .padding(.top, 0)
        }
        .padding(.top, 0)
    }
}

struct GoingToView: View {
    var body: some View {
        HStack {
            Image("Location", bundle: Bundle(identifier: "com.multiverse.iOS-BUS"))
                .frame(width: 24, height: 24)
                .frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(100)
                .overlay(
                    RoundedRectangle(cornerRadius: 100)
                        .inset(by: 0.5)
                        .stroke(Color(red: 0.2, green: 0.2, blue: 0.2), lineWidth: 1))
                .padding(.trailing, 10)
            Button {
            } label: {
                Text("Going to")
                    .font(
                        Font.custom("Metropolis", size: 18)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8))
            }
            Spacer()
        }
    }
}

struct CalendarView: View {
    var body: some View {
        HStack {
            Image("calendar", bundle: Bundle(identifier: "com.multiverse.iOS-BUS"))
                .padding(.trailing, 22)
            VStack(alignment: .leading, spacing: 2){
                Text("Date")
                    .font(Font.custom("Metropolis", size: 12))
                    .foregroundColor(Color(red: 0.53, green: 0.53, blue: 0.53))
                Text("Thu, 12 Sep")
                    .font(
                        Font.custom("Metropolis", size: 16)
                            .weight(.semibold)
                    )
                    .foregroundColor(Color(red: 0.93, green: 0.93, blue: 0.93))
            }
            Spacer()
        }
        .padding(.leading, 16)
    }
}

struct TodayChip: View {
    var body: some View {
        Button(action: {
        }) {
            Text("Today")
                .frame(maxWidth: .infinity)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke()
                        .stroke(lineWidth: 0.5)
                        .foregroundColor(Color(hex: "#333333"))
                )
        }
        .padding(.leading, 2)
    }
}

struct TomorrowChip: View {
    var body: some View {
        Button(action: {
        }) {
            Text("Tomorrow")
                .lineLimit(1)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke()
                        .stroke(lineWidth: 0.5)
                        .foregroundColor(Color(hex: "#333333"))
                )
        }
    }
}

struct MoreDatesChip: View {
    var body: some View {
        ForEach(0..<5) { date in
            Button(action: {
            }) {
                Text("14 September")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke()
                            .stroke(lineWidth: 0.5)
                            .foregroundColor(Color(hex: "#333333"))
                    )
            }
        }
        .frame(maxWidth: .infinity)
    }
}


struct QuickTypeDatesView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            LazyHGrid(rows: [GridItem(.flexible())], spacing: 20) {
                TodayChip()
                TomorrowChip()
                MoreDatesChip()
            }
        }
        .padding(.top, 0)
    }
}

struct HomePageAnimationView: View {
    var body: some View {
        Image("CBus Stand")
            .padding(.top, 30)
    }
}

struct HomePage: View {
    var body: some View {
        ZStack{
            Color.black
            Text("Home Page")
                .font(.largeTitle)
                .foregroundColor(.white)
                
        }
        .background(Color.black)
    }
}

struct ThirdTabView: View {
    var body: some View {
        ZStack{
            Color.black
            Text("Third Tab")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .background(Color.black)
    }
}

struct CommonMethods {
    func separator() -> some View {
        return Rectangle()
            .frame(height: 1)
            .foregroundColor(Color(hex: "#333333"))
    }
}
