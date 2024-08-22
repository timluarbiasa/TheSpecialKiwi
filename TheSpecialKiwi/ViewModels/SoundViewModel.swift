import SwiftUI
import Combine
import AVFoundation

class SoundViewModel: ObservableObject {
    @Published var sounds: [SoundModel] = Array(repeating: SoundModel(), count: 4)
    @Published var kiwiSuccess: Bool = false
    @Published var gameOver: Bool = false
    @Published var didWin: Bool = false
    @Published var showOverlay: Bool = true

    private var timer: Timer?
    private var randomizedLottieAnimations: [String] = []
    private var interactionOrder: [Int] = []
    private var currentActiveIndex: Int = 0
    private var successfulHolds: Int = 0
    private var audioPlayer: AVAudioPlayer?
    private var stopTime: AnyCancellable?

    init() {
//        startGame()
//        startTimer()
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            self.didWin = false
            self.endGame()
        }
    }

    func startGame() {
        randomizedLottieAnimations = ["Fruit1-2", "Fruit2-2", "Fruit3-2", "Fruit4-2"].shuffled()
        interactionOrder = Array(0..<sounds.count).shuffled()
        
        //startTimer()
        resetSounds()
        
        kiwiSuccess = false
        currentActiveIndex = 0
        successfulHolds = 0
        if !showOverlay && !gameOver{
            activateNextFruit()
        }
        print("Justin: Start")
    }
    
    func endGame() {
        timer?.invalidate()
        gameOver = true
        stopAllSounds()
        print("Justin: Ended")
    }

    private func resetSounds() {
        for i in 0..<sounds.count {
            sounds[i].isRed = false
            sounds[i].isSuccess = false
        }
    }
    
    private func activateNextFruit() {
        if gameOver == false {
            guard currentActiveIndex < interactionOrder.count else {
                return
            }

            let index = interactionOrder[currentActiveIndex]
            sounds[index].isRed = true
            
            playSound(for: index)
            
            stopTime = Just(())
                .delay(for: .seconds(2), scheduler: RunLoop.main)
                .sink { [weak self] in
                    self?.moveToNextFruit()
                }
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
        
        stopTime?.cancel()

        if successfulHolds >= 4 {
            kiwiSuccess = true
            resetSounds()
            stopAllSounds()
            didWin = true
            gameOver = true
        } else if gameOver == false {
            moveToNextFruit()
        }
    }

    private func playSound(for index: Int) {
        let soundName = "Fruit\(index + 1)"
        if let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
                print("Justin: play sound")
            } catch {
                print("Justin: Error playing sound: \(error.localizedDescription)")
            }
        }
    }

    private func stopAllSounds() {
        audioPlayer?.stop()
        audioPlayer = nil
    }

    func stopSound() {
        stopAllSounds()
    }

    func randomLottieName(for index: Int) -> String {
        return randomizedLottieAnimations[index]
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

