//
//  ArrowModel.swift
//  TheSpecialKiwi
//
//  Created by James Cellars on 14/08/24.
//

import Foundation
import SwiftUI

struct ArrowModel {
    var position: CGFloat
    var isMovingDown: Bool = true
    let speed: CGFloat = 2.0
    let totalHeight: CGFloat = 300
    
    mutating func updatePosition() {
        //Makes sure when arrow is moving down, it doesn't exceed the gauge
        if isMovingDown {
            position += speed
            if position >= totalHeight {
                position = totalHeight
                isMovingDown = false
            }
        } else {
            //Moves the arrow up the gauge
            position -= speed
            if position <= 0 {
                position = 0
                isMovingDown = true
            }
        }
    }
    
    mutating func resetPosition() {
        position = totalHeight / 2
        isMovingDown = true
    }
}
