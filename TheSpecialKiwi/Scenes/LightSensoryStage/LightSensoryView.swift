//
//  LightSensoryView.swift
//  TheSpecialKiwi
//
//  Created by Muhammad Afif Fadhlurrahman on 14/08/24.
//

import SwiftUI
import SDWebImageSwiftUI
import SDWebImageLottieCoder

struct LightSensoryView: View {
    @StateObject private var viewModel: LightSensoryViewModel
    @StateObject private var timerHelper: TimerHelper
    
    init() {
        let screenWidth = UIScreen.main.bounds.width
        let timerHelperInstance = TimerHelper(totalTime: 10)
        
        // Initialize the viewModel with the timerHelperInstance
        _viewModel = StateObject(wrappedValue: LightSensoryViewModel(screenWidth: screenWidth, timerHelper: timerHelperInstance))
        
        // Assign the timerHelperInstance to _timerHelper
        _timerHelper = StateObject(wrappedValue: timerHelperInstance)
    }
    
    var body: some View {
        ZStack {
            Image("LightSensory_Background1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            if viewModel.gameOver {
                Color(viewModel.didWin ? .green : .red)
                    .ignoresSafeArea()
                    .overlay(
                        VStack {
                            Text(viewModel.didWin ? "You Won" : "You Lose")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .bold()
                            
                            Button(action: {
                                viewModel.resetGame()
                                timerHelper.resetTimer() // Reset the timer when the game resets
                            }) {
                                Text("Play Again")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black.opacity(0.7))
                                    .cornerRadius(10)
                            }
                            .padding(.top, 20)
                        }
                    )
            } else {
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
                                Image("LightSensory_KiwiHappy")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 400, height: 400)
                                    .offset(x: 250, y: 10)
                            } else {
                                WebImage(url: Bundle.main.url(forResource: "KiwiLight", withExtension: "json"))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 400, height: 400)
                                    //.offset(x: 250, y: 10)
                            }
                            
                            Image("LightSensory_Texture")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .blendMode(.multiply)
                        }
                        .ignoresSafeArea()
                    }
                    TimerComponent(timerHelper: timerHelper)
                        .padding(.top, -390)
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
            }
        }
    }
}

#Preview {
    LightSensoryView()
}
