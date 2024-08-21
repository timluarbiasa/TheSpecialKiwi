//
//  ScoreModel.swift
//  TheSpecialKiwi
//
//  Created by Justin Jefferson on 21/08/24.
//

import SwiftData
import Foundation

@Model
class PlayerScore {
    var id: String = UUID().uuidString // Automatically generated unique ID
    var totalScore: Int = 0 // Cumulative score across all stages
    var highScore: Int = 0 // Tracks the player's highest score

    // Default initializer
    init() {}

    // Method to calculate score for each stage and add it to the total score
    func addStageScore(totalTime: Int, timeLeft: Int) {
        let stageScore = Int(((Double(totalTime) - Double(timeLeft)) / Double(totalTime)) * 100)
        totalScore += stageScore
    }

    // Method to update high score at the end of the game
    func updateHighScore() {
        if totalScore > highScore {
            highScore = totalScore
        }
    }

    // Optional reset method to start a new game and clear total score
    func resetGame() {
        totalScore = 0
    }
}
