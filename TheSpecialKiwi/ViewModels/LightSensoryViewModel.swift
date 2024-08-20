//
//  LightSensoryViewModel.swift
//  TheSpecialKiwi
//
//  Created by Muhammad Afif Fadhlurrahman on 14/08/24.
//

import SwiftUI

import SwiftUI

class LightSensoryViewModel: ObservableObject {
    @Published var rectangleWidth: CGFloat
    @Published var characterWidth: CGFloat = 75
    @Published var gameOver: Bool = false
    @Published var didWin: Bool = false
    @Published var showKiwiHappy: Bool = false
    
    let screenWidth: CGFloat
    private var timerHelper: TimerHelper

    init(screenWidth: CGFloat, timerHelper: TimerHelper) {
        self.screenWidth = screenWidth
        self.rectangleWidth = screenWidth * 0.1
        self.timerHelper = timerHelper
        
        // Set up the callback for when the timer ends
        self.timerHelper.onTimerEnd = { [weak self] in
            guard let self = self else { return }
            self.didWin = false
            self.endGame() // Mark the game as lost
        }
    }

    func endGame() {
        timerHelper.stopTimer() // Stop the timer when the game ends
        gameOver = true
    }

    func resetGame() {
        rectangleWidth = screenWidth * 0.1
        gameOver = false
        didWin = false
        showKiwiHappy = false
        timerHelper.resetTimer() // Reset the timer when the game resets
    }

    func handleSwipe() {
        let increment = screenWidth / 30.0 // 10, 20, 30
        if rectangleWidth >= screenWidth * 0.75 - increment {
            showKiwiHappy = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.transitionToWin()
            }
        }
        
        if rectangleWidth >= screenWidth * 0.75 {
            rectangleWidth = screenWidth
            didWin = true
            endGame()
        }
        
        rectangleWidth += increment
    }
    
    private func transitionToWin() {
        if showKiwiHappy {
            didWin = true
            endGame()
        }
    }
}
