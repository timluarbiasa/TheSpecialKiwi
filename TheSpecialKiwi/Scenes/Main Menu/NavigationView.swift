//
//  NavigationView.swift
//  TheSpecialKiwi
//
//  Created by James Cellars on 14/08/24.
//

import SwiftUI

struct NavigationView: View {
    @EnvironmentObject var viewModel: NavigationViewModel
    let movementBounds = CGRect(x: 0, y: 0, width: 300, height: 300)
    
    var body: some View {
            NavigationStack {
                Image("StartPage")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(-1)
                    .offset(y: 40)
                Text("0")
                    .offset(x: 320, y: -85)
                    .font(.custom("LilitaOne", size: 36))
                    .foregroundColor(Color(hex: "#FACF38"))
                VStack {
                    HStack(alignment: .center) {
                        Spacer()
                        
                        Button(action: {
                            // your code here!
                        }) {
                            Image("MuteButton")
                                .padding(.vertical, 10)
                        }
                        .padding(.top, -75)
                        .padding(.leading, 70)
                        
                        Button(action: {
                            // your code here!
                            viewModel.navigateToGame(.informationGame)
                        }) {
                            Image("InformationButton")
                                .padding(.vertical, 10)
                        }
                        .padding(.top, -75)
                        .padding(.leading, 8)
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.navigateToGame(.communication)
                        }) {
                            Image("StartButton")
                                .padding()
                        }
                        .padding(.top, -55)
                        .padding(.bottom, 26)
                        .padding(.leading, 450)
                        
                        Spacer()
                    }
                }
                .navigationBarBackButtonHidden(!viewModel.isBackButtonVisible)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        if viewModel.isBackButtonVisible {
                            Button(action: {
                                viewModel.goBack()
                            }) {
                                Text("Back")
                            }
                        }
                    }
                }
                .navigationDestination(isPresented: Binding(
                    get: { viewModel.currentGame == .communication },
                    set: { if !$0 { viewModel.goBack() } }
                )) {
                    CommunicationGameView(viewModel: CommunicationGameViewModel())
                }
//                .navigationDestination(destination: CommunicationGameView(viewModel: CommunicationGameViewModel()), isActive: Binding(
//                    get: { viewModel.currentGame == .communication },
//                    set: { if !$0 { viewModel.goBack() } }
//                )) {
//                    EmptyView()
//                }
//                .hidden()
//                .navigationDestination(isPresented: Binding(
//                    get: { viewModel.currentGame == .eyeContact },
//                    set: { if !$0 { viewModel.goBack() } }
//                )) {
//                    EyeContactStageView(viewModel: EyeContactStageViewModel(movementBounds: movementBounds))
//                }
                .navigationDestination(isPresented: Binding(
                    get: { viewModel.currentGame == .lightSensory },
                    set: { if !$0 { viewModel.goBack() } }
                )) {
                    LightSensoryView()
                        .navigationBarBackButtonHidden()
                }
                .navigationDestination(isPresented: Binding(
                    get: { viewModel.currentGame == .informationGame },
                    set: { if !$0 { viewModel.goBack() } }
                )) {
                    InformationView()
                        .ignoresSafeArea()
                        .navigationBarBackButtonHidden()
                }
            }
        }
    }
