//
//  EyeContactStageViewModel.swift
//  TheSpecialKiwi
//
//  Created by James Cellars on 14/08/24.
//

import Foundation
import SwiftUI
import Combine

class EyeContactStageViewModel: ObservableObject {
    @Published var currentAsset: String = "KiwiLeft"
    @Published var isRunning: Bool = false
    @Published var resultMessage: String = ""
    
    private var timer: Timer?
    private var showingDirectEyeContact: Bool = false
    
    //List of assets
    let lottieAssets = ["KiwiLeft", "KiwiRight"]
    let directEyeContactAsset = "KiwiFront"
    
    func startGame() {
        isRunning = true
        resetGame()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.randomizeAsset()
        }
    }
    
    func stopGame() {
        isRunning = false
        timer?.invalidate()
    }
    
    private func randomizeAsset() {
        if showingDirectEyeContact {
            showingDirectEyeContact = false
            currentAsset = lottieAssets.randomElement()!
        } else {
            if Bool.random() {
                //50% chance to switch to direct eye contact
                currentAsset = directEyeContactAsset
                showingDirectEyeContact = true
                
                //Start short timer for certain amount of time player has to touch the screen
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                    if self.showingDirectEyeContact {
                        self.loseGame()
                    }
                }
            } else {
                currentAsset = lottieAssets.randomElement()!
            }
        }
    }
    
    func handleTap() {
        if showingDirectEyeContact {
            winGame()
        } else {
            loseGame()
        }
    }
    
    func resetGame() {
        resultMessage = ""
        currentAsset = lottieAssets.randomElement()!
    }
    
    private func winGame() {
        stopGame()
        resultMessage = "You Win!"
    }
    
    private func loseGame() {
        stopGame()
        resultMessage = "You Lose!"
    }
}
