//
//  CommunicationGameView.swift
//  TheSpecialKiwi
//
//  Created by James Cellars on 14/08/24.
//

import SwiftUI

struct CommunicationGameView: View {
    @ObservedObject var viewModel: CommunicationGameViewModel
    
    let backgroundImageName = "BackgroundJPG"
    let gaugeImageName = "Bar"
    let arrowImageName = "Arrow"
    
    var body: some View {
        ZStack {
            //Background image
//            Image(backgroundImageName)
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
//                .zIndex(-10)
            
            if !viewModel.resultImageName.isEmpty {
                Image(viewModel.resultImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 860, height: 860)
                    .padding()
                    .zIndex(0)
            }
            
            //Main content
            VStack(spacing: 0) {
                //Gauge image
                Image(gaugeImageName)
                    .resizable()
                    .frame(width: 50, height: viewModel.gauge.totalHeight)
                    .offset(x: -350, y: 0)
                    .zIndex(1)
                    .overlay(
                    VStack {
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
            
            //Arrow image
            Image(arrowImageName)
                .resizable()
                .frame(width: 30, height: 50)
                .offset(x: -380, y: viewModel.arrow.position - 150)
                .zIndex(2)
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
