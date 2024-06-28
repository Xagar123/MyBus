import SwiftUI
import iOS_Common_Utilities

public struct BusMoreInfoView: View {
    @StateObject private var viewModel = BusMoreInfoViewModel()
    
    public init() { }
    
    public var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                VStack(spacing: 12) {
                    BusMoreInfoMainDetailsView(busInfo: viewModel.busInfo ?? BusInfo(name: "", type: "", rating: "", reviews: ""))
                        .padding([.leading, .trailing], 16)
                    BusMoreInfoSectionsListView(busSectionsList: viewModel.busSectionsList ?? [BusSectionList(title: "ed", imageURL: "Dc")], selectedTab: $viewModel.selectedTab)
                        .padding([.leading, .trailing], 16)
                    Divider()
                        .padding(.all, 0)
                        .frame(height: 1)
                        .overlay(Color(hex: "#333333"))
                    BusMoreInfoDetailsView(selectedTab: $viewModel.selectedTab, viewModel: viewModel)
                        .padding([.leading, .trailing], 16)
                }
                .frame(alignment: .top)
                .padding(.top, 20)
            }
        }
        .background(Color(hex: "#222222"))
    }
}

//#Preview {
//    BusMoreInfoView()
//        .preferredColorScheme(.dark)
//}
