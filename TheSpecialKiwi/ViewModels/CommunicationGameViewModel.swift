import Foundation
import SwiftUI
import Combine
import AVFoundation

class CommunicationGameViewModel: ObservableObject {
    @Published var arrow: ArrowModel
    @Published var gauge: GaugeModel
    @Published var resultMessage: String = ""
    @Published var isRunning: Bool = false
    @Published var hasWon: Bool = false
    @Published var hasLost: Bool = false
    @Published var kiwiSuccess: Bool = false

    private var timer: Timer?
    private var audioPlayer: AVAudioPlayer?
    private var timerHelper: TimerHelper
    private var scoreViewModel: ScoreViewModel

    init(timerHelper: TimerHelper, scoreViewModel: ScoreViewModel) {
        self.arrow = ArrowModel(position: 150)
        self.gauge = GaugeModel(position: 150)
        self.timerHelper = timerHelper
        self.scoreViewModel = scoreViewModel
        
        // Set up callback for when timer ends
        self.timerHelper.onTimerEnd = { [weak self] in
            guard let self = self else { return }
            self.hasWon = false
            self.hasLost = true
            self.scoreViewModel.updateHighScore()
            self.scoreViewModel.resetScore()
        }
        loadSoundEffect()
    }

    func loadSoundEffect() {
        if let soundURL = Bundle.main.url(forResource: "Volume", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.numberOfLoops = -1 // Loops indefinitely
                print("Sound playing")
            } catch {
                print("Error loading sound effect: \(error)")
            }
        }
    }

    func startArrow() {
        isRunning = true
        resultMessage = ""
        audioPlayer?.play()
        hasWon = false
        hasLost = false
        timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { [weak self] _ in self?.updateArrowPosition()
        }
    }

    func stopArrow() {
        isRunning = false
        timer?.invalidate()
        timer = nil
        audioPlayer?.stop()
        checkResult()
    }

    private func updateArrowPosition() {
        arrow.updatePosition()
    }

    private func checkResult() {
        print("Checking result")
        let result = gauge.checkResult(arrowPosition: arrow.position)
        resultMessage = result
        if result == "KiwiHappy" {
            kiwiSuccess = true
            hasWon = true
            scoreViewModel.increaseScore(by: 100) // Correctly updating score
        }
        hasWon = result == "KiwiHappy"
        hasLost = result == "You Lose!"
    }

    func resetArrow() {
        arrow.resetPosition()
        resultMessage = ""
        hasWon = false
        hasLost = false
    }
}
