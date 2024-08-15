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
            
            if viewModel.currentAsset == viewModel.directEyeContactAsset {
                Image(viewModel.currentAsset)
                    .frame(width: 300, height: 300)
                    .position(x: 425, y: 208)
            } else {
                LottieView(filename: viewModel.currentAsset)
                    .frame(width: 390, height: 390)
                    .position(x: 425, y: 208)
            }
            
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
