//
//  GameOverViewModel.swift
//  TheSpecialKiwi
//
//  Created by James Cellars on 20/08/24.
//

import Foundation
import SwiftUI

class GameOverViewModel: ObservableObject {
    @Published var shouldRetry: Bool = false
    
    func retry() {
        shouldRetry = true
        stopSound()
    }
    
    func stopSound() {
        audioPlayer?.stop() // Stop the currently playing sound
    }
}
