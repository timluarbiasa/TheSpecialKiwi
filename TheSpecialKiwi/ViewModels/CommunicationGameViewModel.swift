//
//  CommunicationGameViewModel.swift
//  TheSpecialKiwi
//
//  Created by James Cellars on 14/08/24.
//

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
    
    init(timerHelper: TimerHelper) {
        self.arrow = ArrowModel(position: 150)
        self.gauge = GaugeModel(position: 150)
        self.timerHelper = timerHelper
        
        //Set up callback for when timer ends
        self.timerHelper.onTimerEnd = { [weak self] in
            guard let self = self else { return }
            self.hasWon = false
            self.hasLost = true
        }
    }
    
    //Loads the sound effect
    func loadSoundEffect() {
        if let soundURL = Bundle.main.url(forResource: "Volume", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.numberOfLoops = -1 //Loops indefinitely
                audioPlayer?.play()
                print("James: Sound playing")
            } catch {
                print("James: Error loading sound effect: \(error)")
            }
        }
    }

    
    func startArrow() {
        isRunning = true
        resultMessage = ""
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
        print("James: Checking result")
        let result = gauge.checkResult(arrowPosition: arrow.position)
        resultMessage = result
        if result == "KiwiHappy" {
            kiwiSuccess = true
            hasWon = true
        }
        hasWon = result == "KiwiHappy"
        hasLost = result == "You Lose!"
        audioPlayer?.stop()
    }
    
    func resetArrow() {
        arrow.resetPosition()
        resultMessage = ""
        hasWon = false
        hasLost = false
    }
    
    func playWinSound() {
        // Load the sound file from the app bundle
        if let url = Bundle.main.url(forResource: "LightSensory_Success", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Error: Could not load win sound file - \(error.localizedDescription)")
            }
        } else {
            print("Error: Win sound file not found")
        }
    }
}
