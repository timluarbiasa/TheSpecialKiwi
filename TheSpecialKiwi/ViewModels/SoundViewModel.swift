//
//  SoundViewModel.swift
//  TheSpecialKiwi
//
//  Created by Justin Jefferson on 20/08/24.
//

import SwiftUI
import Combine
import AVFoundation

class SoundViewModel: ObservableObject {
    @Published var sounds: [SoundModel] = Array(repeating: SoundModel(), count: 4)
    @Published var kiwiSuccess: Bool = false

    private var randomizedLottieAnimations: [String] = []
    private var interactionOrder: [Int] = []
    private var currentActiveIndex: Int = 0
    private var successfulHolds: Int = 0
    private var timer: AnyCancellable?
    private var audioPlayer: AVAudioPlayer?

    init() {
        startGame()
    }

    func startGame() {
        randomizedLottieAnimations = ["Fruit1-2", "Fruit2-2", "Fruit3-2", "Fruit4-2"].shuffled()
        interactionOrder = Array(0..<sounds.count).shuffled()
        
        resetSounds()
        
        kiwiSuccess = false
        currentActiveIndex = 0
        successfulHolds = 0
        activateNextFruit()
    }

    private func resetSounds() {
        for i in 0..<sounds.count {
            sounds[i].isRed = false
            sounds[i].isSuccess = false
        }
    }
    
    private func activateNextFruit() {
        guard currentActiveIndex < interactionOrder.count else {
            return
        }

        let index = interactionOrder[currentActiveIndex]
        sounds[index].isRed = true
        
        playSound(for: index)

        timer = Just(())
            .delay(for: .seconds(2), scheduler: RunLoop.main)
            .sink { [weak self] in
                self?.moveToNextFruit()
            }
    }

    private func moveToNextFruit() {
        guard currentActiveIndex < interactionOrder.count else {
            return
        }

        let index = interactionOrder[currentActiveIndex]
        sounds[index].isRed = false
        
        currentActiveIndex += 1
        
        if currentActiveIndex >= interactionOrder.count {
            currentActiveIndex = 0
        }

        activateNextFruit()
    }

    func pressBlock(at index: Int) {
        guard sounds[index].isRed, !sounds[index].isSuccess else { return }
        
        sounds[index].isSuccess = true
        sounds[index].isRed = false
        successfulHolds += 1
        
        timer?.cancel()

        if successfulHolds >= 4 {
            kiwiSuccess = true
            resetSounds()
            stopSound()
        } else {
            moveToNextFruit()
        }
    }

    private func playSound(for index: Int) {
        let soundName = "Fruit\(index + 1)" // Corresponding sound file name
        if let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }

    private func stopSound() {
        audioPlayer?.stop()
    }

    func randomLottieName(for index: Int) -> String {
        return randomizedLottieAnimations[index]
    }
}
