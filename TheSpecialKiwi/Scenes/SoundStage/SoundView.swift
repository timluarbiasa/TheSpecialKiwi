//
//  SoundView.swift
//  TheSpecialKiwi
//
//  Created by Justin Jefferson on 20/08/24.
//

import SwiftUI
import Lottie

struct SoundView: View {
    @StateObject var viewModel: SoundViewModel
    @StateObject var timerHelper = TimerHelper(totalTime: 10) // 10 seconds for demonstration
    
    @State private var navigateToGameOver = false
    @State private var navigateToCommunicationGame = false
    
    init() {
        let timerHelperInstance = TimerHelper(totalTime: 10)
        
        _viewModel = StateObject(wrappedValue: SoundViewModel())
        
        _timerHelper = StateObject(wrappedValue: timerHelperInstance)
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("BG-2")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                if viewModel.kiwiSuccess {
                    Image("Kiwi%20Success")
                        .resizable()
                        .scaledToFit()
                        .position(x: geometry.size.width / 2, y: geometry.size.height - 165)
                } else {
                    LottieView(name: "Kiwi", loopMode: .loop, shouldPlay: .constant(true))
                        .position(x: geometry.size.width / 2, y: geometry.size.height - 165)
                }

                ForEach(0..<4) { index in
                    VStack {
                        if viewModel.sounds[index].isRed {
                            LottieView(name: "Fruit\(index + 1)-2", loopMode: .playOnce, shouldPlay: .constant(true))
                                .frame(width: geometry.size.width * 0.69, height: geometry.size.height * 0.69)
                        } else {
                            Image("Fruit\(index + 1)%20Success-3")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.6)
                        }
                    }
                    .position(fruitPosition(index: index, geometry: geometry))
                    
                    Circle()
                        .opacity(0.01)
                        .frame(width: 162, height: 162)
                        .gesture(
                            LongPressGesture(minimumDuration: 0.1)
                                .onEnded { _ in
                                    viewModel.pressBlock(at: index)
                                    let generator = UINotificationFeedbackGenerator()
                                    generator.notificationOccurred(.success)
                                    print(index)
                                }
                        )
                        .position(fruitPosition(index: index, geometry: geometry))
                }

                // Add the TimerComponent to the view
                TimerComponent(timerHelper: timerHelper)
                    .position(x: geometry.size.width / 2, y: geometry.size.height * 0.021)
                    .onAppear {
                        timerHelper.startTimer()
                    }
                NavigationLink(
                    destination: GameOverView(viewModel: GameOverViewModel()),
                    isActive: $navigateToGameOver
                ) {
                    EmptyView()
                }
                .hidden()
                
                NavigationLink(
                    destination: CommunicationGameView(),
                    isActive: $navigateToCommunicationGame
                ) {
                    EmptyView()
                }
                .hidden()
                
                .onChange(of: viewModel.gameOver) { gameOver in
                    if gameOver {
                        viewModel.stopSound()
                        if viewModel.didWin {
                            navigateToCommunicationGame = true
                        } else {
                            viewModel.stopSound()
                            navigateToGameOver = true
                        }
                    }
                }
            }
        }
        .onDisappear {
            viewModel.stopSound()
            viewModel.endGame()
        }
    }

    private func fruitPosition(index: Int, geometry: GeometryProxy) -> CGPoint {
        switch index {
        case 0: return CGPoint(x: geometry.size.width * 0.12, y: geometry.size.height * 0.6)
        case 1: return CGPoint(x: geometry.size.width * 0.38, y: geometry.size.height * 0.38)
        case 2: return CGPoint(x: geometry.size.width * 0.64, y: geometry.size.height * 0.38)
        case 3: return CGPoint(x: geometry.size.width * 0.9, y: geometry.size.height * 0.6)
        default: return CGPoint.zero
        }
    }
}

#Preview {
    SoundView()
        .previewInterfaceOrientation(.landscapeLeft)
}

