//
//  CommunicationGameView.swift
//  TheSpecialKiwi
//
//  Created by James Cellars on 14/08/24.
//

import SwiftUI

struct CommunicationGameView: View {
    @ObservedObject var viewModel: CommunicationGameViewModel
    @State private var navigateToLightSensory = false
    @State private var navigateToGameOver = false
    
    let backgroundImageName = "BackgroundJPG"
    let gaugeImageName = "Bar"
    let arrowImageName = "Arrow"
    let texture = "Texture"

    var body: some View {
        NavigationStack {
            ZStack {
                //Lottie animation
                if !viewModel.kiwiSuccess {
                    LottieCommunicationView(name: "KiwiVolume", loopMode: .loop)
                        .zIndex(-1)
                        .edgesIgnoringSafeArea(.all)
                }
                
                if viewModel.kiwiSuccess {
                    Image("KiwiHappy")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 860, height: 860)
                        .padding()
                        .zIndex(10)
                        .offset(x: 5, y: -20)  // Adjust to position the image as desired
                        .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                navigateToLightSensory = true
                            }
                        }
                }
                
                VStack(spacing: 0) {
                    Image(gaugeImageName)
                        .resizable()
                        .frame(width: 50, height: viewModel.gauge.totalHeight)
                        .offset(x: -350, y: 0)
                        .zIndex(1)
                        .overlay(
                        VStack(spacing: 0) {
                            Rectangle()
                                .fill(Color.red)
                                .frame(height: viewModel.gauge.totalHeight / 3)
                                .offset(y: 4)
                                .opacity(0)
                            Rectangle()
                                .fill(Color.green)
                                .frame(height: viewModel.gauge.totalHeight / 3)
                                .offset(y: -4)
                                .opacity(0)
                            Rectangle()
                                .fill(Color.yellow)
                                .frame(height: viewModel.gauge.totalHeight / 3)
                                .offset(y: -12)
                                .opacity(0)
                        }
                    )
                }
                            
                if viewModel.hasWon {
                    NavigationLink(
                        destination: LightSensoryView().navigationBarBackButtonHidden(),
                        isActive: $navigateToLightSensory
                    ) {
                        EmptyView()
                    }
                }
                
                if viewModel.hasLost {
                    NavigationLink(
                        destination: GameOverView(viewModel: GameOverViewModel()),
                        isActive: $navigateToGameOver
                    ) {
                        EmptyView()
                    }
                    .hidden()
                    .onAppear {
                        navigateToGameOver = true
                    }
                }
                
                //Background image
                Image(backgroundImageName)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(-10)
                
                //Arrow image
                Image(arrowImageName)
                    .resizable()
                    .frame(width: 30, height: 50)
                    .offset(x: -380, y: viewModel.arrow.position - 150)
                    .zIndex(12)
                Image(texture)
                    .resizable()
                    .zIndex(13)
                    .blendMode(.multiply)
            }
            .onTapGesture {
                if viewModel.isRunning {
                    viewModel.stopArrow()
                } else {
                    viewModel.startArrow()
                }
            }
            .onAppear {
                viewModel.resetArrow()
            }
        }
    }
}

struct CommunicationGameView_Previews: PreviewProvider {
    static var previews: some View {
        CommunicationGameView(viewModel: CommunicationGameViewModel())
    }
}
