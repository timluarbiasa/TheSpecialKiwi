//
//  LightSensoryView.swift
//  TheSpecialKiwi
//
//  Created by Muhammad Afif Fadhlurrahman on 14/08/24.
//

import SwiftUI
import Lottie

struct LightSensoryView: View {
    @StateObject private var viewModel: LightSensoryViewModel
    @StateObject private var timerHelper: TimerHelper
    
    @State private var navigateToGameOver = false
    @State private var navigateToCommunicationGame = false
    @State private var showOverlay = true // Manage overlay visibility
    
    init() {
        let screenWidth = UIScreen.main.bounds.width
        let timerHelperInstance = TimerHelper(totalTime: 10)
        
        // Initialize the viewModel with the timerHelperInstance
        _viewModel = StateObject(wrappedValue: LightSensoryViewModel(screenWidth: screenWidth, timerHelper: timerHelperInstance))
        
        // Assign the timerHelperInstance to _timerHelper
        _timerHelper = StateObject(wrappedValue: timerHelperInstance)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if showOverlay{
                    // Display the SVG overlay instead of the OverlayView
                    Image("OverlayLightSensory")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .onTapGesture {
                            // Hide the overlay when tapped
                            showOverlay = false
                        }
                } else {
                    Image("LightSensory_Background1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
            
                        VStack {
                            HStack {
                                ZStack(alignment: .leading) {
                                    Rectangle()
                                        .fill(Color.brown)
                                        .frame(width: viewModel.rectangleWidth, height: 150)
                                        .overlay(
                                            Image("LightSensory_Curtain")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: viewModel.rectangleWidth, height: 450)
                                                .clipped()
                                        )
                                        .animation(.easeInOut(duration: 0.9), value: viewModel.rectangleWidth)
                                        .offset(x: 0, y: -40)
                                    
                                    Image("LightSensory_Background2")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                    
                                    
                                    if viewModel.showKiwiHappy {
                                        LottieView(name: "KiwiHappy1", shouldPlay: .constant(true))
                                    } else {
                                        LottieView(name: "KiwiLight", shouldPlay: .constant(true))
                                    }
                                    
                                    Image("LightSensory_Texture")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .blendMode(.multiply)
                                }
                                .ignoresSafeArea()
                            }
                            TimerComponent(timerHelper: timerHelper)
                                .padding(.top, -400)
                        }
                        .contentShape(Rectangle())
                        .onAppear {
                            timerHelper.startTimer()
                        }
                        .gesture(
                            DragGesture()
                                .onEnded { value in
                                    if value.translation.width > 0 {
                                        viewModel.handleSwipe() // Handle the swipe action
                                    }
                                }
                        )
                    
                    //NavigationLink to Game Over View
                    NavigationLink(
                        destination: GameOverView(viewModel: GameOverViewModel()).navigationBarBackButtonHidden(),
                        isActive: $navigateToGameOver
                    ) {
                        EmptyView()
                    }
                    .hidden()
                    
                    // NavigationLink to SoundView on win
                    NavigationLink(
                        destination: CommunicationGameView().navigationBarBackButtonHidden(),
                        isActive: $navigateToCommunicationGame
                    ) {
                        EmptyView()
                    }
                    .hidden()
                }
            }
        }
        .onChange(of: viewModel.gameOver) { gameOver in
            if gameOver {
                if viewModel.didWin {
                    navigateToCommunicationGame = true
                    viewModel.playWinSound()
                } else {
                    navigateToGameOver = true
                }
            }
        }
    }
}

#Preview {
    LightSensoryView()
}
