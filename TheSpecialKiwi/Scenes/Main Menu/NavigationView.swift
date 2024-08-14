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
                VStack {
                    Text("Choose a Mini Game")
                        .font(.largeTitle)
                        .padding()
                    
                    HStack {
                        Button(action: {
                            viewModel.navigateToGame(.communication)
                        }) {
                            Text("Communication Game")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding()
                        
                        Button(action: {
                            viewModel.navigateToGame(.eyeContact)
                        }) {
                            Text("Eye Contact Game")
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding()
                    }
                }
                .navigationTitle("Mini Games")
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
