import Foundation
import SwiftUI
import Lottie
import Combine

class EyeContactStageViewModel: ObservableObject {
    @Published var currentAsset: String = "KiwiLeft"
    @Published var isRunning: Bool = false
    @Published var resultMessage: String = ""
    @Published var currentFrame: AnimationFrameTime = 1 // Track the current frame
    
    private var timer: Timer?
    
    // List of assets (KiwiLeft and KiwiRight animations only)
    let assets = ["KiwiLeft", "KiwiRight"]
    
    func startGame() {
        isRunning = true
        resetGame()
        
        // Start timer to randomize assets
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.randomizeAsset()
        }
    }
    
    func stopGame() {
        isRunning = false
        timer?.invalidate()
    }
    
    private func randomizeAsset() {
        // Randomly select between KiwiLeft and KiwiRight
        currentAsset = assets.randomElement()!
    }
    
    func handleTap() {
        // Check if tap was within the desired frame range for direct eye contact
        if (currentFrame >= 1 && currentFrame <= 10) || (currentFrame >= 80 && currentFrame <= 90) {
            winGame()
        } else {
            loseGame()
        }
    }
    
    func resetGame() {
        resultMessage = ""
        currentAsset = assets.randomElement()!
        currentFrame = 0 // Reset the current frame
    }
    
    private func winGame() {
        stopGame()
        resultMessage = "You Win!"
    }
    
    private func loseGame() {
        stopGame()
        resultMessage = "You Lose!"
    }
    
    // Function to update the current frame from the LottieView
    func updateCurrentFrame(_ frame: AnimationFrameTime) {
        self.currentFrame = frame
    }
}
