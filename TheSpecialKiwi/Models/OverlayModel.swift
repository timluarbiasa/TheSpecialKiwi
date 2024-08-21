//
//  OverlayModel.swift
//  TheSpecialKiwi
//
//  Created by Justin Jefferson on 21/08/24.
//

import SwiftUI

class OverlayModel: ObservableObject {
    @Published var stageTitle: String = ""
    @Published var stagePercentage: String = ""
    @Published var stageDescriptionPart1: String = ""
    @Published var stageDescriptionPart2: String = ""
    @Published var tapDescription: String = ""
    @Published var tapDescriptionPart2: String = ""
    @Published var titleColor: Color = .yellow
    @Published var percentageColor: Color = .pink
    @Published var descriptionColor: Color = .pink
    @Published var holdIcon: String = "load.png"
    @Published var tapIcon: String = "tap.png"
    @Published var overlayBackgroundImage: String = "Stage Info Overlay - Eye Contact.png"
    
    // Property to track the colored range of the tapDescription
    @Published var tapColoredRange: Range<String.Index>?

    func configureStage(for stage: GameStage) {
        switch stage {
        case .EyeContactStageView:
            stageTitle = "EYE CONTACT DIFFICULTIES"
            stagePercentage = "50-90%"
            stageDescriptionPart1 = "autistic people have trouble"
            stageDescriptionPart2 = "keeping eye contact."
            tapDescription = "Tap the screen every time Kiwi"
            tapDescriptionPart2 = "does to compliment him!"
            tapColoredRange = tapDescription.range(of: "Tap the screen")
            titleColor = Color("ColorBackgroundAccents")
            percentageColor = Color("PinkMagenta")
            descriptionColor = Color("PinkMagenta")
            holdIcon = "load.png"
            tapIcon = "tap.png"
            overlayBackgroundImage = "Stage Info Overlay - Eye Contact.png"
        case .volumeControl:
            stageTitle = "VOLUME CONTROL DIFFICULTIES"
            stagePercentage = "20-60%"
            stageDescriptionPart1 = "autistic people have troubles"
            stageDescriptionPart2 = "controlling their speech volume."
            tapDescription = "Tap the screen to inform Kiwi"
            tapDescriptionPart2 = "whenever he’s speaking in the right volume!"
            tapColoredRange = tapDescription.range(of: "Tap the screen")
            titleColor = Color("ColorBackgroundAccents")
            percentageColor = Color("PinkMagenta")
            descriptionColor = Color("PinkMagenta")
            holdIcon = "load.png"
            tapIcon = "tap.png"
            overlayBackgroundImage = "Stage Info Overlay - Eye Contact.png"
        case .LightSensoryView:
            stageTitle = "LIGHT OVERSTIMULATION"
            stagePercentage = "50-70%"
            stageDescriptionPart1 = "autistic people have"
            stageDescriptionPart2 = "hypersensitivity to bright lights."
            tapDescription = "Pull the curtain to block the"
            tapDescriptionPart2 = "blazing sunlight from Kiwi!"
            tapColoredRange = tapDescription.range(of: "Pull the curtain")
            titleColor = Color("ColorBackgroundAccents")
            percentageColor = Color("PinkMagenta")
            descriptionColor = Color("PinkMagenta")
            holdIcon = "load.png"
            tapIcon = "tap.png"
            overlayBackgroundImage = "Stage Info Overlay - Eye Contact.png"
        case .SoundView:
            stageTitle = "SOUND OVERSTIMULATION"
            stagePercentage = "65-80%"
            stageDescriptionPart1 = "autistic people have"
            stageDescriptionPart2 = "hypersensitivity to loud sounds."
            tapDescription = "Hold Kiwi’s talkative friends to"
            tapDescriptionPart2 = "tell them to stop speaking."
            tapColoredRange = tapDescription.range(of: "Hold Kiwi’s talkative friends")
            titleColor = Color("ColorBackgroundAccents")
            percentageColor = Color("PinkMagenta")
            descriptionColor = Color("PinkMagenta")
            holdIcon = "load.png"
            tapIcon = "tap.png"
            overlayBackgroundImage = "Stage Info Overlay - Eye Contact.png"
        }
    }
}

enum GameStage {
    case EyeContactStageView
    case volumeControl
    case LightSensoryView
    case SoundView
}
