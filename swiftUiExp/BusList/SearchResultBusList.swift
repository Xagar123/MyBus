//
//  ContentView.swift
//  POC2
//
//  Created by Sagar on 01/06/24.
//

import SwiftUI

struct SearchResultBusList: View {
    
    @ObservedObject var viewModel = BusServiceViewModel()
    
    var body: some View {
        VStack{
            CustomHeaderView()
                .padding(.top,8)
//            CustomFilterView()
            HorizintalFilterView()
                .padding(.top,16)
            
            if viewModel.hasFetchedData {
                BusListView(viewModel: viewModel)
            }else {
                EmptyBusListView()
                .padding(.top,120)
            }
        }
        .background(Color(hex:"#111111"))
    }
}


#Preview {
    SearchResultBusList()
}



struct CustomHeaderView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: geometry.size.height / 2)
                                 
                    .fill(Color(hex: "#181818"))
                    .overlay(
                        RoundedRectangle(cornerRadius: geometry.size.height / 2)
                            .stroke(Color(hex: "#333333"), lineWidth: 1)
                    )
                
                HStack {

                    Image(uiImage: UIImage(named: "backBtnArrow")!)
                        .frame(width: 24, height: 24)
                        .padding(.leading,12)
                    
                    VStack(alignment: .leading) {
                        Text("Bengaluru to Goa")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("19 Jun, Sat")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical,5)
                    .padding(.leading,12)
                    .padding(.trailing,40)
                    
                    Spacer()
                    CircleWithPencil()
                }
                .padding(.trailing, 10)
            }
            .frame(height: 56)
        }
        .frame(height: 56)
        .padding(.horizontal,16)
    }
}


struct CircleWithPencil: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @State private var isPresentingModal = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(hex: "#333333"), lineWidth: 1)
                .frame(width: 40, height: 40)
            
            Image(uiImage: UIImage(named: "filter")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .foregroundColor(.white)
        }
        .onTapGesture {
            isPresentingModal = true
//            coordinator.navigate(to: .FilterView)
           
        }
        .sheet(isPresented: $isPresentingModal, content: {
            FilterFullScreen()
                .background(Color.clear)
        })
        
        .padding(.trailing,0)
        
    }
}


struct BusListView: View {
    
    @ObservedObject var viewModel : BusServiceViewModel
   
    var body: some View {
        List {
            ForEach($viewModel.busServices) { item in
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        VStack(alignment: .leading,spacing: 0) {
                            Text(item.travelerAgentName.wrappedValue)
                                .foregroundColor(Color(hex: "#EEEEEE"))
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            Text(item.busTypeName.wrappedValue)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.top,2)
                        }
                        .padding(.top,12)
                        .padding(.horizontal,12)
                        
                        Spacer()
                        
                        VStack {
                            HStack(spacing: 0) {
                                Image("Star")
                                //                            .padding(4)
                                Text("2.5")
                                    .font(.system(size: 12))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.top,2)
                                    .padding(.bottom,2)
                                    .padding(.leading,2)
                                    .padding(.trailing,4)
                                
                            }
                            .background(Color(hex: "#F2503F"))
                            .frame(width: 45,height: 17)
                            .cornerRadius(4)
                            
                            Text("1.6k")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .font(.system(size: 12))
                                .padding(.top,-4)
                        }
                        .padding(.trailing,12)
                        .padding(.top,12)
                        //                .padding(.horizontal,12)
                    }
                    .padding(.top,8)
                    HStack {
                        VStack(alignment:.leading) {
                            HStack {
                                Text(item.startTime.wrappedValue)
//                                    .font(.title2)
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(hex: "##EEEEEE"))
                               
                                Image("pointAtoB")
                                
                                Text(item.arrTime.wrappedValue)
//                                    .font(.title2)
                                    .foregroundColor(Color(hex: "##EEEEEE"))
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                            }
                            Text(item.travelTime.wrappedValue)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("Starts @")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                            HStack {
                                Image("rupee₹")
                                
                                Text("\(item.fare.wrappedValue)")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .padding(.trailing)
                                    .foregroundColor(Color(hex: "#FEFEFE"))
                                
                            }
                        }
                        //                .padding(.trailing,8)
                    }
                    .padding(.leading,12)
                    .frame(height:65)
                    
                    Text("\(item.availableSeats.wrappedValue) Seats left")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.leading,12)
                    //                .padding(.top,12)
                    
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.gray)
                        .frame(maxWidth: .infinity, maxHeight: 0.5)
                    //                .padding(.top,8)
                    
                    HStack {
                        
                        Image("Tracking")
                        
                        Text("Live Tracking")
                            .foregroundColor(Color(hex: "##EEEEEE"))
                        
                        Spacer()
                        Text("More info")
                            .padding(.trailing,12)
                            .foregroundColor(Color.blue)
                    }
                    .padding(.leading,12)
                    .padding(.bottom,18)
                    
                }
                .background(Color(hex: "#222222"))
                .cornerRadius(16)
                .listRowInsets(EdgeInsets())
                .padding(.vertical,12)
                .background(Color(hex:"#111111"))
                .listRowSeparator(.hidden)
            }
           
        }
        .scrollIndicators(.hidden)
        .listStyle(PlainListStyle())
        .padding(.horizontal,16)
        .background(Color(hex:"#111111"))
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
    }
}






enum FilterImage: String {
    case sort_by = "expand_all"
    case ac = "ac"
    case non_ac = "non_ac"
    case single = "chair"
    case sleeper = "Sleeper"
}
