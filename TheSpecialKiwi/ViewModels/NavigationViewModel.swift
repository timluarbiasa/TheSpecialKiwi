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
}

class NavigationViewModel: ObservableObject {
    @Published var currentGame: Game?
    @Published var isBackButtonVisible: Bool = false
    
    func navigateToGame(_ game: Game) {
        currentGame = game
        isBackButtonVisible = true
    }
    
    func goBack() {
        currentGame = nil
        isBackButtonVisible = false
    }
}
