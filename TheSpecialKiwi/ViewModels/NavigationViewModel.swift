//
//  NavigationViewModel.swift
//  TheSpecialKiwi
//
//  Created by James Cellars on 14/08/24.
//

import Foundation
import SwiftUI

enum Game {
    case communication
    case eyeContact
    case lightSensory
    case informationGame
    case gameOver
}

class NavigationViewModel: ObservableObject {
    @Published var currentGame: Game?
    
    func navigateToGame(_ game: Game) {
        currentGame = game
    }
    
    func goBack() {
        currentGame = nil
    }
}
