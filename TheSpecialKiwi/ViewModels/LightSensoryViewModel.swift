//
//  LightSensoryViewModel.swift
//  TheSpecialKiwi
//
//  Created by Muhammad Afif Fadhlurrahman on 14/08/24.
//

import SwiftUI

class LightSensoryViewModel: ObservableObject {
    @Published var rectangleWidth: CGFloat
    @Published var characterWidth: CGFloat = 75
    @Published var timeRemaining: Int = 10
    @Published var gameOver: Bool = false
    @Published var didWin: Bool = false
    @Published var progress: CGFloat = 1.0
    @Published var showKiwiHappy: Bool = false
    
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
                self.progress = CGFloat(self.timeRemaining) / 10.0
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
        rectangleWidth = screenWidth * 0.1
        timeRemaining = 10
        gameOver = false
        didWin = false
        showKiwiHappy = false
        startTimer()
    }
    
    func handleSwipe() {
        let increment = screenWidth / 10.0
        if rectangleWidth >= screenWidth - increment{
            showKiwiHappy = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.transitionToWin()
            }
            //print("DEBUG: Masuk sini!")
            //print("DEBUG: rectangleWidth: \(rectangleWidth) || screenWidth: \(screenWidth)")
        }
        
        if rectangleWidth >= screenWidth {
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
