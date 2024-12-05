//
//  TimerHelper.swift
//  TheSpecialKiwi
//
//  Created by Reyhan Ariq Syahalam on 13/08/24.
//

import SwiftUI
import Combine

class TimerHelper: ObservableObject {
    @Published var timeRemaining: CGFloat
    @Published var progress: CGFloat = 1.0
    
    let totalTime: CGFloat
    private var timer: Timer?
    
    var onTimerEnd: (() -> Void)?

    init(totalTime: CGFloat) {
        self.totalTime = totalTime
        self.timeRemaining = totalTime
    }

    func startTimer() {
        timer?.invalidate() // Invalidate any existing timer
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 0.1
                self.progress = self.timeRemaining / self.totalTime
            } else {
                self.timer?.invalidate()
                self.timeRemaining = 0
                self.onTimerEnd?() // Notify that the timer has ended
            }
        }
    }

    func resetTimer() {
        timeRemaining = totalTime
        progress = 1.0
        startTimer()
    }

    func stopTimer() {
        timer?.invalidate()
    }
}


