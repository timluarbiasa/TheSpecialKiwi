//
//  EyeContactStageView.swift
//  TheSpecialKiwi
//
//  Created by Reyhan Ariq Syahalam on 13/08/24.
//

import SwiftUI

struct EyeContactStageView: View {
    @ObservedObject var viewModel: EyeContactStageViewModel
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.black)
                .frame(width: 30, height: 30)
                .position(viewModel.eye.position)
            
            if !viewModel.resultMessage.isEmpty {
                Text(viewModel.resultMessage)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(viewModel.resultMessage == "You Win!" ? .green : .red)
                    .background(Color.white.opacity(0.7))
                    .padding()
            }
        }
        .frame(width: 300, height: 300)
        .border(Color.black, width: 1)
        .onTapGesture {
            if viewModel.isRunning {
                viewModel.stopMovement()
                viewModel.checkResult()
            } else {
                viewModel.startMovement()
            }
        }
        .onAppear {
            viewModel.resetGame()
        }
    }
}

struct EyeContactStageView_Previews: PreviewProvider {
    static var previews: some View {
        EyeContactStageView(viewModel: EyeContactStageViewModel(movementBounds: CGRect(x: 0, y: 0, width: 300, height: 300)))
    }
}
