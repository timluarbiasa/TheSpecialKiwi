//
//  ScoreViewModel.swift
//  TheSpecialKiwi
//
//  Created by James Cellars on 22/08/24.
//

import Foundation
import SwiftUI

class ScoreViewModel: ObservableObject {
    @Published var currentScore: Int
    @Published var highScore: Int
    
    init(currentScore: Int = 0, highScore: Int = 0) {
        self.currentScore = currentScore
        self.highScore = highScore
    }
    
    func increaseScore(by amount: Int) {
        currentScore += amount
        print(currentScore)
    }
    
    func updateHighScore() {
        if currentScore > highScore {
            highScore = currentScore
        }
    }
    
    func resetScore() {
        currentScore = 0
    }
}
