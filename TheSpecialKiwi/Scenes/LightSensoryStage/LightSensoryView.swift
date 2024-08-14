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
                    // Display the remaining time with a frame and border
                    Text("Time Remaining: \(viewModel.timeRemaining)s")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                        )
                        .padding(.top, 20)

                    Spacer() // Spacer between the timer and the rectangle

                    HStack {
                        Spacer() // Push the rectangle to the right

                        ZStack(alignment: .trailing) {
                            // Circle behind the rectangle
                            Circle()
                                .fill(Color.red)
                                .frame(width: 100, height: 200)
                                .offset(x: -viewModel.screenWidth / 2) // Position the circle partially outside the right edge
                            
                            // Rectangle that starts at 10% of the screen width on the right
                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: viewModel.rectangleWidth, height: 200)
                                .overlay(
                                    Image("texture-2")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: viewModel.rectangleWidth, height: 200)
                                        .clipped() // Ensure the image fits within the rectangle bounds
                                )
                                .animation(.easeInOut(duration: 0.9), value: viewModel.rectangleWidth) // Smooth animation for width change
                        }
                    }
                    .padding(.leading) // Ensure the rectangle starts from the right edge
                    
                    Spacer()

                    Text("Swipe left to fill the screen in 10 seconds!")
                        .padding()

                    Spacer()
                }
                .contentShape(Rectangle()) // Make the whole screen swipable
                .onAppear {
                    viewModel.startTimer() // Start the timer when the view appears
                }
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            // Check if the user swiped left
                            if value.translation.width < 0 {
                                viewModel.handleSwipe() // Handle the swipe action
                            }
                        }
                )
                .padding()
                .background(Color(UIColor.systemGray5))
            }
        }
    }
}

#Preview {
    LightSensoryView()
}
