//
//  CommunicationGameView.swift
//  TheSpecialKiwi
//
//  Created by James Cellars on 14/08/24.
//

import SwiftUI

struct CommunicationGameView: View {
    @ObservedObject var viewModel: CommunicationGameViewModel
    @State private var navigateToEyeContact = false
    @State private var navigateToGameOver = false

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.red)
                        .frame(height: viewModel.gauge.totalHeight / 3)
                    Rectangle()
                        .fill(Color.green)
                        .frame(height: viewModel.gauge.totalHeight / 3)
                    Rectangle()
                        .fill(Color.yellow)
                        .frame(height: viewModel.gauge.totalHeight / 3)
                }
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 20, height: 20)
                    .position(x:50, y: viewModel.arrow.position)
                
                if !viewModel.resultMessage.isEmpty {
                    Text(viewModel.resultMessage)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(viewModel.resultMessage == "You Win!" ? .green : .red)
                        .background(Color.white.opacity(0.7))
                        .padding()
                }
                
                if viewModel.hasWon {
                    NavigationLink(
                        destination: EyeContactStageView(viewModel: EyeContactStageViewModel(movementBounds: CGRect(x: 0, y: 0, width: 300, height: 300))),
                        isActive: $navigateToEyeContact
                    ) {
                        Button(action: {
                            navigateToEyeContact = true
                        }) {
                            Text("Go to Eye Contact Stage")
                                .font(.title)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()
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
            }
            .frame(width: 100, height: viewModel.gauge.totalHeight)
            .border(Color.black, width: 1)
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
