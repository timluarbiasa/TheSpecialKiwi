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
                    
                    HStack {
                        Button(action: {
                            viewModel.navigateToGame(.communication)
                        }) {
                            Image("StartButton")
                                .padding()
                        }
                        .padding(.top, -55)
                        .padding(.bottom, 26)
                        .padding(.leading, 550)
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
                .background(
                    NavigationLink(destination: CommunicationGameView(viewModel: CommunicationGameViewModel()), isActive: Binding(
                        get: { viewModel.currentGame == .communication },
                        set: { if !$0 { viewModel.goBack() } }
                    )) {
                        EmptyView()
                    }
                    .hidden()
                )
                .background(
                    NavigationLink(destination: EyeContactStageView(viewModel: EyeContactStageViewModel(movementBounds: movementBounds)), isActive: Binding(
                        get: { viewModel.currentGame == .eyeContact },
                        set: { if !$0 { viewModel.goBack() } }
                    )) {
                        EmptyView()
                    }
                    .hidden()
                )
            }
        }
    }
