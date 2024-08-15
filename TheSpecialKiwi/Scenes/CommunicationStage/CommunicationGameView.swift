//
//  CommunicationGameView.swift
//  TheSpecialKiwi
//
//  Created by James Cellars on 14/08/24.
//

import SwiftUI

struct CommunicationGameView: View {
    @ObservedObject var viewModel: CommunicationGameViewModel
    
    let gaugeImageName = "Bar"
    let arrowImageName = "Arrow"
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                //Gauge image
                Image(gaugeImageName)
                    .resizable()
                    .frame(width: 50, height: viewModel.gauge.totalHeight)
                    .position(x: -300, y: viewModel.gauge.position)
                    .overlay(
                    VStack {
                        Rectangle()
                            .fill(Color.red)
                            .frame(height: viewModel.gauge.totalHeight / 3)
                            .position(x: 100, y: 45)
                            .opacity(0)
                        Rectangle()
                            .fill(Color.green)
                            .frame(height: viewModel.gauge.totalHeight / 3)
                            .position(x: 100, y: 52)
                            .opacity(0)
                        Rectangle()
                            .fill(Color.yellow)
                            .frame(height: viewModel.gauge.totalHeight / 3)
                            .position(x: 100, y: 58)
                            .opacity(0)
                    }
                )
            }
            
            //Arrow image
            Image(arrowImageName)
                .resizable()
                .frame(width: 30, height: 50)
                .position(x: -330, y: viewModel.arrow.position)
            
            if !viewModel.resultMessage.isEmpty {
                Text(viewModel.resultMessage)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(viewModel.resultMessage == "You Win!" ? . green : .red)
                    .background(Color.white.opacity(0.7))
                    .padding()
            }
        }
        .frame(width: 100, height: viewModel.gauge.totalHeight)
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

struct CommunicationGameView_Previews: PreviewProvider {
    static var previews: some View {
        CommunicationGameView(viewModel: CommunicationGameViewModel())
    }
}
