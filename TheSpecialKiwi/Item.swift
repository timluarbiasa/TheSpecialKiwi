//
//  Item.swift
//  TheSpecialKiwi
//
//  Created by Reyhan Ariq Syahalam on 13/08/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
