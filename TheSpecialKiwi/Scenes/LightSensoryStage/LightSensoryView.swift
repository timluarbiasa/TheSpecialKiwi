//
//  LightSensoryView.swift
//  TheSpecialKiwi
//
//  Created by Muhammad Afif Fadhlurrahman on 14/08/24.
//

import SwiftUI

struct LightSensoryView: View {
    @StateObject private var viewModel: LightSensoryViewModel

    init() {
        let screenWidth = UIScreen.main.bounds.width
        _viewModel = StateObject(wrappedValue: LightSensoryViewModel(screenWidth: screenWidth))
    }

    var body: some View {
        ZStack {
            Image("LightSensory_Background1")
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            Image("LightSensory_Background2")
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            if viewModel.gameOver {
                // Show "You Won" or "You Lose" with background color based on the outcome
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
                        ZStack(alignment: .leading) {                             Rectangle()
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
                            
                            Image("LightSensory_KiwiHappy")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                    }
                }
                
                .contentShape(Rectangle()) // Make the whole screen swipable
                .onAppear {
                    viewModel.startTimer() // Start the timer when the view appears
                }
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            // Check if the user swiped left
                            if value.translation.width > 0 {
                                viewModel.handleSwipe() // Handle the swipe action
                            }
                        }
                )
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LightSensoryView()
}

