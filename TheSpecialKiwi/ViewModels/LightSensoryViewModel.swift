//
//  LightSensoryViewModel.swift
//  TheSpecialKiwi
//
//  Created by Muhammad Afif Fadhlurrahman on 14/08/24.
//

import SwiftUI

class LightSensoryViewModel: ObservableObject {
    @Published var rectangleWidth: CGFloat
    @Published var timeRemaining: Int = 10
    @Published var gameOver: Bool = false
    @Published var didWin: Bool = false
    
    let screenWidth: CGFloat
    private var timer: Timer?

    init(screenWidth: CGFloat) {
        self.screenWidth = screenWidth
        self.rectangleWidth = screenWidth * 0.1 // Initialize rectangleWidth to 10% of the screen width
    }

    func startTimer() {
        timer?.invalidate() // Invalidate any existing timer
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.didWin = false
                self.endGame()
            }
        }
    }

    func endGame() {
        timer?.invalidate()
        timer = nil
        gameOver = true
    }

    func resetGame() {
        rectangleWidth = screenWidth * 0.1 // Reset the rectangle width to 10% of the screen width
        timeRemaining = 10
        gameOver = false
        didWin = false
        startTimer() // Restart the timer immediately
    }

    func handleSwipe() {
        let increment = screenWidth / 10.0 // Calculate the width increment needed to fill the screen in 10 swipes
        rectangleWidth += increment

        if rectangleWidth >= screenWidth {
            rectangleWidth = screenWidth
            didWin = true
            endGame()
        }
    }
}

