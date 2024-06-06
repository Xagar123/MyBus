////
////  BusListView.swift
////  POC2
////
////  Created by Sagar on 06/06/24.
////
//
//import Foundation
//import SwiftUI
//
////MARK: - Bus List
//struct BusListView: View {
//    
//    @ObservedObject var viewModel = BusServiceViewModel()
//   
//    var body: some View {
//        List {
//            ForEach($viewModel.busServices) { item in
//                VStack(alignment: .leading, spacing: 16) {
//                    HStack {
//                        VStack(alignment: .leading,spacing: 0) {
//                            Text(item.travelerAgentName.wrappedValue)
//                                .foregroundColor(Color(hex: "#EEEEEE"))
//                                .font(.title3)
//                                .fontWeight(.semibold)
//                            
//                            Text(item.busTypeName.wrappedValue)
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                                .padding(.top,2)
//                        }
//                        .padding(.top,12)
//                        .padding(.horizontal,12)
//                        
//                        Spacer()
//                        
//                        VStack {
//                            HStack(spacing: 0) {
//                                Image("Star")
//                                //                            .padding(4)
//                                Text("2.5")
//                                    .font(.system(size: 12))
//                                    .fontWeight(.bold)
//                                    .foregroundColor(.white)
//                                    .padding(.top,2)
//                                    .padding(.leading,2)
//                                    .padding(.trailing,4)
//                                
//                            }
//                            .background(Color(hex: "#F2503F"))
//                            .frame(width: 50,height: 24)
//                            .cornerRadius(2)
//                            
//                            Text("1.6k")
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                                .font(.system(size: 10))
//                                .padding(.top,2)
//                        }
//                        .padding(.trailing,12)
//                        .padding(.top,12)
//                        //                .padding(.horizontal,12)
//                    }
//                    .padding(.top,8)
//                    HStack {
//                        VStack(alignment:.leading) {
//                            HStack {
//                                Text(item.startTime.wrappedValue)
////                                    .font(.title2)
//                                    .font(.system(size: 20))
//                                    .fontWeight(.bold)
//                                    .foregroundColor(Color(hex: "##EEEEEE"))
//                               
//                                Image("pointAtoB")
//                                
//                                Text(item.arrTime.wrappedValue)
////                                    .font(.title2)
//                                    .foregroundColor(Color(hex: "##EEEEEE"))
//                                    .font(.system(size: 20))
//                                    .fontWeight(.bold)
//                            }
//                            Text(item.travelTime.wrappedValue)
//                                .foregroundColor(.gray)
//                        }
//                        
//                        Spacer()
//                        
//                        VStack {
//                            Text("Starts @")
//                                .font(.system(size: 12))
//                                .foregroundColor(.gray)
//                            HStack {
//                                Image("rupee₹")
//                                
//                                Text("\(item.fare.wrappedValue)")
//                                    .font(.system(size: 20))
//                                    .fontWeight(.bold)
//                                    .padding(.trailing)
//                                    .foregroundColor(Color(hex: "#FEFEFE"))
//                                
//                            }
//                        }
//                        //                .padding(.trailing,8)
//                    }
//                    .padding(.leading,12)
//                    .frame(height:65)
//                    
//                    Text("\(item.availableSeats.wrappedValue) Seats left")
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                        .padding(.leading,12)
//                    //                .padding(.top,12)
//                    
//                    RoundedRectangle(cornerRadius: 0)
//                        .fill(Color.gray)
//                        .frame(maxWidth: .infinity, maxHeight: 0.5)
//                    //                .padding(.top,8)
//                    
//                    HStack {
//                        
//                        Image("Tracking")
//                        
//                        Text("Live Tracking")
//                            .foregroundColor(Color(hex: "##EEEEEE"))
//                        
//                        Spacer()
//                        Text("More info")
//                            .padding(.trailing,12)
//                            .foregroundColor(Color.blue)
//                    }
//                    .padding(.leading,12)
//                    .padding(.bottom,18)
//                    
//                }
//                .background(Color(hex: "#222222"))
//                .cornerRadius(16)
//                .listRowInsets(EdgeInsets())
//                .padding(.vertical,12)
//                .background(Color(hex:"#111111"))
//                .listRowSeparator(.hidden)
//            }
//           
//        }
//        .scrollIndicators(.hidden)
//        .listStyle(PlainListStyle())
//        .padding(.horizontal,16)
//        .background(Color(hex:"#111111"))
//        .listRowInsets(EdgeInsets())
//        .listRowSeparator(.hidden)
//    }
//}
