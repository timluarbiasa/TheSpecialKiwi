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
    
    init() {
        let screenWidth = UIScreen.main.bounds.width
        _viewModel = StateObject(wrappedValue: LightSensoryViewModel(screenWidth: screenWidth))
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
                                WebImage(url: Bundle.main.url(forResource: "KiwiHappy", withExtension: "json"))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 400, height: 400)
                                    .offset(x: 250, y: 10)
                            } else {
                                WebImage(url: Bundle.main.url(forResource: "KiwiHappy", withExtension: "json"))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .offset(x: 0, y: 0)
                            }
                            
                            Image("LightSensory_Texture")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .blendMode(.multiply)
                        }
                        .ignoresSafeArea()
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
                
//                VStack {
//                    GeometryReader { geometry in
//                        ZStack(alignment: .leading) {
//                            Rectangle()
//                                .fill(Color.gray.opacity(0.5))
//                                .frame(width: geometry.size.width, height: 12)
//                            
//                            Rectangle()
//                                .fill(Color.brown)
//                                .frame(width: geometry.size.width * viewModel.progress, height: 12)
//                                .animation(.linear(duration: 1), value: viewModel.progress)
//                        }
//                    }
//                    .frame(height: 12)
//                    .padding(.horizontal, 20)
//                    .padding(.top, -5)
//                    .offset(y: -180)
//                }
            }
        }
    }
}

#Preview {
    LightSensoryView()
}

