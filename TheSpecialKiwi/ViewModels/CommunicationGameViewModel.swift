//
//  CommunicationGameViewModel.swift
//  TheSpecialKiwi
//
//  Created by James Cellars on 14/08/24.
//

import Foundation
import SwiftUI
import Combine

class CommunicationGameViewModel: ObservableObject {
    @Published var arrow: ArrowModel
    @Published var gauge: GaugeModel
    @Published var resultMessage: String = ""
    @Published var isRunning: Bool = false
    @Published var hasWon: Bool = false
    
    private var timer: Timer?
    
    init() {
        self.arrow = ArrowModel(position: 150)
        self.gauge = GaugeModel()
    }
    
    func startArrow() {
        isRunning = true
        resultMessage = ""
        hasWon = false
        timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { [weak self] _ in self?.updateArrowPosition()
        }
    }
    
    func stopArrow() {
        isRunning = false
        timer?.invalidate()
        timer = nil
        checkResult()
    }
    
    private func updateArrowPosition() {
        arrow.updatePosition()
    }
    
    private func checkResult() {
        let result = gauge.checkResult(arrowPosition: arrow.position)
        resultMessage = result
        hasWon = result == "You Win!"
    }
    
    func resetArrow() {
        arrow.resetPosition()
        resultMessage = ""
        hasWon = false
    }
}
