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
    @Published var eye: EyeModel
    @Published var resultMessage: String = ""
    @Published var isRunning: Bool = false
    
    private var timer: Timer?
    private let movementBounds: CGRect
    
    init(movementBounds: CGRect) {
        self.eye = EyeModel(position: CGPoint(x: movementBounds.midX, y: movementBounds.midY), direction: .up)
        self.movementBounds = movementBounds
    }
    
    func startMovement() {
        isRunning = true
        resultMessage = ""
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { [weak self] _ in self?.updateEyePosition()
        }
    }
    
    func stopMovement() {
        isRunning = false
        timer?.invalidate()
        timer = nil
        checkResult()
    }
    
    private func updateEyePosition() {
        eye.moveRandomly(within: movementBounds)
    }
    
    func checkResult() {
        if eye.isLookingAtPlayer() {
            resultMessage = "You Win!"
        } else {
            resultMessage = "You Lose!"
        }
    }
    
    func resetGame() {
        eye.position = CGPoint(x: movementBounds.midX, y: movementBounds.midY)
        eye.direction = .up
        resultMessage = ""
    }
}
