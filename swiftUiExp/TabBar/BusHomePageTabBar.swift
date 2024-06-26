//
//  BusHomePageTabBar.swift
//  swiftUiExp
//
//  Created by Sagar on 26/06/24.
//

import SwiftUI

public struct BusHomePageTabBar: View {
    @State private var selectedTab = 1
    
    public init() {
    }
    
    public var body: some View {
        ZStack{
            Color.black
            TabView(selection: $selectedTab){
                HomePage()
                    .tabItem {
                        Image(selectedTab == 0 ? "TabHomeFilledIcon" : "TabHomeIcon", bundle: Bundle(identifier: "com.multiverse.iOS-BUS"))
                        if selectedTab == 0 {
                            Text("Home")
                                .font(
                                    Font.custom("Metropolis", size: 12)
                                        .weight(.bold)
                                )
                        }
                    }
                    .tag(0)
                BusSearchHomePage()
                    .tabItem {
                        Image(selectedTab == 1 ? "TabSearchFilledIcon" : "TabSearchIcon", bundle: Bundle(identifier: "com.multiverse.iOS-BUS"))
                        if selectedTab == 1 {
                            Text("Search")
                                .font(
                                    Font.custom("Metropolis", size: 12)
                                        .weight(.bold)
                                )
                        }
                    }
                    .tag(1)
                ThirdTabView()
                    .tabItem {
                        Image(selectedTab == 2 ? "TabLuggageFilledIcon" : "TabLuggageIcon", bundle: Bundle(identifier: "com.multiverse.iOS-BUS"))
                        if selectedTab == 2 {
                            Text("My trips")
                                .font(
                                    Font.custom("Metropolis", size: 12)
                                        .weight(.bold)
                                )
                        }
                    }
                    .tag(2)
            }
            .tint(.white)
        }
    }
}

#Preview {
    BusHomePageTabBar()
}



