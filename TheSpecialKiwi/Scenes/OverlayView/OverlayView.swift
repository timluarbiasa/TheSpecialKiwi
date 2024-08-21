//
//  OverlayView.swift
//  TheSpecialKiwi
//
//  Created by Justin Jefferson on 21/08/24.
//

import SwiftUI

struct OverlayView: View {
    @ObservedObject var viewModel: OverlayModel
    var onTapContinue: () -> Void // Closure to handle tap event

    var body: some View {
        ZStack {
            Color("ColorSecondary")
                .edgesIgnoringSafeArea(.all)
                .opacity(0.8)
            
            VStack(spacing: 20) {
                HStack {
                    Image("dangers")
                        .resizable()
                        .frame(width: 40, height: 40)
                    
                    Text(viewModel.stageTitle)
                        .padding(25)
                        .font(.custom("Lilita One", size: 36))
                        .foregroundColor(viewModel.titleColor)
                        .multilineTextAlignment(.center)
                    
                    Image("dangers")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                
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
                .padding(10)
                
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
                
                HStack(spacing: 5) {
                    Text("TAP")
                        .font(.custom("Lilita One", size: 16))
                        .foregroundColor(viewModel.descriptionColor)
                    Image(systemName: "hand.tap.fill")
                        .foregroundColor(viewModel.descriptionColor)
                    Text("TO CONTINUE")
                        .font(.custom("Lilita One", size: 16))
                        .foregroundColor(viewModel.descriptionColor)
                }
                .foregroundColor(.white)
            }
            .padding(15)
        }
        .onAppear {
            lockOrientationLandscape()
        }
        .onTapGesture {
            onTapContinue() // Trigger the closure to move to the game view
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
        
        // Use the updated method for iOS 16 and later
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: .landscapeLeft))
        } else {
            // Fallback for older iOS versions
            UINavigationController().setNeedsUpdateOfSupportedInterfaceOrientations()
        }
    }
}

// MARK: - Preview
struct StageOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        OverlayView(viewModel: previewViewModel(), onTapContinue: {})
    }
    
    static func previewViewModel() -> OverlayModel {
        let viewModel = OverlayModel()
        viewModel.configureStage(for: .SoundView)
        return viewModel
    }
}
