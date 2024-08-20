//
//  EyeModel.swift
//  TheSpecialKiwi
//
//  Created by James Cellars on 14/08/24.
//

import Foundation
import SwiftUI

struct EyeModel {
    var position: CGPoint
    var direction: Direction
    
    enum Direction {
        case up, down, left, right
        
        static func randomDirection() -> Direction {
            let directions: [Direction] = [.up, .down, .left, .right]
            return directions.randomElement()!
        }
    }
    
    mutating func moveRandomly(within bounds: CGRect) {
        let step: CGFloat = 20.0
        
        switch direction {
        case .up:
            position.y -= step
        case .down:
            position.y += step
        case .left:
            position.x -= step
        case .right:
            position.x += step
        }
        
        //Ensure the eyes stay within bounds
        if position.x < bounds.minX { position.x = bounds.minX }
        if position.x > bounds.maxX { position.x = bounds.maxX }
        if position.y < bounds.minY { position.y = bounds.minY }
        if position.y > bounds.maxY { position.y = bounds.maxY }
        
        //Randomly change direction
        if Int.random(in: 0...5) == 0 {
            direction = Direction.randomDirection()
        }
    }
    
    func isLookingAtPlayer() -> Bool {
        //Assuming that the eyes are "looking" at the player when they're facing up
        //Can be adjusted based on our specific needs
        return direction == .up
    }
}
