//
//  OverlayView.swift
//  TheSpecialKiwi
//
//  Created by Justin Jefferson on 21/08/24.
//

import SwiftUI

struct OverlayView: View {
    @ObservedObject var viewModel: OverlayModel
    
    var body: some View {
        ZStack {
            Color("ColorSecondary")
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                // Title with dangers.png on both sides
                HStack {
                    Image("dangers")
                        .resizable()
                        .frame(width: 40, height: 40) // Adjust size as needed
                    
                    Text(viewModel.stageTitle)
                        .padding(25)
                        .font(.custom("Lilita One", size: 36))
                        .foregroundColor(viewModel.titleColor)
                        .multilineTextAlignment(.center)
                    
                    Image("dangers")
                        .resizable()
                        .frame(width: 40, height: 40) // Adjust size as needed
                }
                
                // Percentage & Description
                VStack(spacing: 1) {
                    Text(viewModel.stagePercentage)
                        .font(.custom("Sora", size: 17))
                        .fontWeight(.bold)
                        .foregroundColor(viewModel.percentageColor)
                        .multilineTextAlignment(.center)
                    
                    VStack {
                        Text(viewModel.stageDescriptionPart1)
                        Text(viewModel.stageDescriptionPart2)
                    }
                    .font(.custom("Sora", size: 13))
                    .foregroundColor(viewModel.descriptionColor)
                    .multilineTextAlignment(.center)
                }
                
                Spacer()
                
                // Tap Description
                VStack(spacing: 1){
                    buildTapDescription()
                        .font(.custom("Sora", size: 17))
                        .multilineTextAlignment(.center)
                        .fontWeight(.bold)
                    
                    Text(viewModel.tapDescriptionPart2)
                        .font(.custom("Sora", size: 17))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                
                // Hold to Pause
                HStack(spacing: 5) {
                    Text("HOLD")
                        .font(.custom("Lilita One", size: 16))
                        .foregroundColor(viewModel.descriptionColor)
                    Image(systemName: "hand.tap")
                    Text("TO PAUSE THE SCREEN")
                        .font(.custom("Lilita One", size: 16))
                        .foregroundColor(viewModel.descriptionColor)
                }
                .foregroundColor(.white)
            }
            .padding(20)
        }
        .onAppear {
            lockOrientationLandscape()
        }
    }
    
    private func buildTapDescription() -> Text {
        let tapDescription = viewModel.tapDescription
        
        if let range = viewModel.tapColoredRange {
            let coloredPart = String(tapDescription[range])
            let startIndex = tapDescription.startIndex
            let endIndex = tapDescription.endIndex
            let preColoredText = String(tapDescription[startIndex..<range.lowerBound])
            let postColoredText = String(tapDescription[range.upperBound..<endIndex])
            
            return Text(preColoredText)
                .foregroundColor(.white) +
                Text(coloredPart)
                .foregroundColor(Color("ColorBackgroundAccents")) +
                Text(postColoredText)
                .foregroundColor(.white)
        } else {
            return Text(tapDescription)
                .foregroundColor(.white)
        }
    }
    
    private func lockOrientationLandscape() {
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
}

// MARK: - Preview
struct StageOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        OverlayView(viewModel: previewViewModel())
    }
    
    static func previewViewModel() -> OverlayModel {
        let viewModel = OverlayModel()
        viewModel.configureStage(for: .lightOverstimulation)
        return viewModel
    }
}
