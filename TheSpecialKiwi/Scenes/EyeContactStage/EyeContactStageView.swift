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
            Image("EyeContactBg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
            // Lottie animation handling for KiwiLeft and KiwiRight
            LottieView(
                filename: viewModel.currentAsset,
                startFrame: 0,
                endFrame: 100, // Assuming the animation has 100 frames
                onFrameUpdate: { frame in
                    viewModel.updateCurrentFrame(frame)
                }
            )
            .frame(width: 400, height: 400)
            
            if !viewModel.resultMessage.isEmpty {
                Text(viewModel.resultMessage)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(viewModel.resultMessage == "You Win!" ? .green : .red)
                    .background(Color.white.opacity(0.7))
                    .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onTapGesture {
            viewModel.handleTap()
        }
        .onAppear {
            viewModel.startGame()
        }
    }
}

struct EyeContactStageView_Previews: PreviewProvider {
    static var previews: some View {
        EyeContactStageView(viewModel: EyeContactStageViewModel())
    }
}
