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
    private let assets = ["KiwiLeft", "KiwiRight"]
    private let directEyeContactAsset = "KiwiFront"
    
    func startGame() {
        isRunning = true
        resetGame()
        
        //Start timer to randomize assets
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
            currentAsset = assets.randomElement()!
        } else {
            if Bool.random() {
                //50% chance to switch to direct eye contact
                currentAsset = directEyeContactAsset
                showingDirectEyeContact = true
                
                //Start short timer for a certain amoun of time player has to react to the direct eye contact
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                    if self.showingDirectEyeContact {
                        self.loseGame()
                    }
                }
            } else {
                currentAsset = assets.randomElement()!
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
        currentAsset = assets.randomElement()!
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
