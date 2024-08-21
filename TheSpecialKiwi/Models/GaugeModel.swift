//
//  GaugeModel.swift
//  TheSpecialKiwi
//
//  Created by James Cellars on 14/08/24.
//

import Foundation
import SwiftUI

struct GaugeModel {
    let totalHeight: CGFloat = 300
    var position: CGFloat
    
    var greenZoneTop: CGFloat {
        totalHeight / 3
    }
    
    var greenZoneBottom: CGFloat {
        2 * totalHeight / 3
    }
    
    func checkResult(arrowPosition: CGFloat) -> String {
        if arrowPosition > greenZoneTop && arrowPosition < greenZoneBottom {
            return "You Win!"
        } else {
            return "You Lose!"
        }
    }
}
