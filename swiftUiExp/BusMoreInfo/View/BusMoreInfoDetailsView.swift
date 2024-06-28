import SwiftUI

struct BusMoreInfoDetailsView: View {
    @Binding var selectedTab: String
    @State private var scrollPosition: Int?
    @StateObject var viewModel: BusMoreInfoViewModel
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                ScrollViewReader { scrollViewReader in
                    List {
                        Section {
                            BusMoreInfoAmenitiesView(amenities: viewModel.amenities)
                                .anchorPreference(key: AnchorsKey.self, value: .center) { [0: $0] }
                        } header: {
                            Text("Amenities")
                                .padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0))
                                .frame(alignment: .leading)
                                .font(.semiBold(size: 18))
                                .foregroundColor(Color(hex: "#EEEEEE"))
                        } footer: {
                            Divider()
                                .frame(height: 1)
                                .overlay(Color(hex: "#333333"))
                        }
                        .textCase(.none)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        
                        Section {
                            BusMoreInfoStopsView(boardingPoints: viewModel.boardingPoints ?? BoardingDroppingHeaderPoints(boardingPointTitle: "Boarding Points", droppingPointTitle: "Dropping Points", boardingPoints: [], droppingPoints: [], selectedBoardingPoint: true))
                                .anchorPreference(key: AnchorsKey.self, value: .center) { [1: $0] }
                        } header: {
                            Text("Bus Stops")
                                .padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0))
                                .frame(alignment: .leading)
                                .font(.semiBold(size: 18))
                                .foregroundColor(Color(hex: "#EEEEEE"))
                        } footer: {
                            Divider()
                                .frame(height: 1)
                                .overlay(Color(hex: "#333333"))
                        }
                        .textCase(.none)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        
                        Section {
                            BusMoreInfoRefundPolicyView(busRefundPolicy: viewModel.refundPolicy)
                                .anchorPreference(key: AnchorsKey.self, value: .center) { [2: $0] }
                        } header: {
                            Text("Refund Policy")
                                .padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0))
                                .frame(alignment: .leading)
                                .font(.semiBold(size: 18))
                                .foregroundColor(Color(hex: "#EEEEEE"))
                        } footer: {
                            Divider()
                                .frame(height: 1)
                                .overlay(Color(hex: "#333333"))
                        }
                        .textCase(.none)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        
                        Section {
                            BusMoreInfoTravelPolicyView(travelPolicy: viewModel.travelPolicy)
                                .anchorPreference(key: AnchorsKey.self, value: .center) { [3: $0] }
                        } header: {
                            Text("Travel Policy")
                                .padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0))
                                .frame(alignment: .leading)
                                .font(.semiBold(size: 18))
                                .foregroundColor(Color(hex: "#EEEEEE"))
                        }
                        .textCase(.none)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                    }
                    .scrollIndicators(.hidden)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .listStyle(.grouped)
                    .onPreferenceChange(AnchorsKey.self) { anchors in
                        scrollPosition = topRow(of: anchors, in: proxy)
                        updateSelectedTab()
                    }
                }
            }
        }
    }

    struct AnchorsKey: PreferenceKey {
        typealias Value = [Int: Anchor<CGPoint>]

        static var defaultValue: Value { [:] }

        static func reduce(value: inout Value, nextValue: () -> Value) {
            value.merge(nextValue()) { $1 }
        }
    }

    private func topRow(of anchors: AnchorsKey.Value, in proxy: GeometryProxy) -> Int? {
        var yBest = CGFloat.infinity
        var answer: Int? = nil
        for (row, anchor) in anchors {
            let y = proxy[anchor].y
            guard y >= 0, y < yBest else { continue }
            answer = row
            yBest = y
        }
        return answer
    }

    private func updateSelectedTab() {
        if let scrollPosition = scrollPosition {
            switch scrollPosition {
            case 0:
                selectedTab = "Amenities"
            case 1:
                selectedTab = "Stops"
            case 2:
                selectedTab = "Refund"
            case 3:
                selectedTab = "Policy"
            default:
                break
            }
        }
    }

}

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: UIScrollView? = nil

    static func reduce(value: inout UIScrollView?, nextValue: () -> UIScrollView?) {
        value = value ?? nextValue()
    }
}

//#Preview {
//    let selectedTab = Binding.constant("Amenities")
//    return BusMoreInfoDetailsView(selectedTab: selectedTab, viewModel: BusMoreInfoViewModel())
//        .preferredColorScheme(.dark)
//}
