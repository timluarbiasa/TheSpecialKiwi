//
//  LottieView.swift
//  TheSpecialKiwi
//
//  Created by James Cellars on 15/08/24.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let filename: String
    var startFrame: AnimationFrameTime = 1
    var endFrame: AnimationFrameTime = 90
    var onFrameUpdate: ((AnimationFrameTime) -> Void)?

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView(name: filename)
        animationView.frame = view.bounds
        animationView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        animationView.loopMode = .loop // Set the loop mode to loop
        animationView.contentMode = .scaleAspectFill

        animationView.play(fromFrame: startFrame, toFrame: endFrame) { (finished) in
            // The animation finished playing the given frame range, continue looping
            animationView.play(fromFrame: startFrame, toFrame: endFrame)
        }

        view.addSubview(animationView)
        animationView.play()

        // Observer for frame updates
        animationView.addObserver(context.coordinator, forKeyPath: "currentFrame", options: .new, context: nil)

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // Update the view if needed
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(onFrameUpdate: onFrameUpdate)
    }

    class Coordinator: NSObject {
        var onFrameUpdate: ((AnimationFrameTime) -> Void)?

        init(onFrameUpdate: ((AnimationFrameTime) -> Void)?) {
            self.onFrameUpdate = onFrameUpdate
        }

        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if keyPath == "currentFrame", let animationView = object as? LottieAnimationView, let currentFrame = change?[.newKey] as? CGFloat {
                onFrameUpdate?(AnimationFrameTime(currentFrame))
            }
        }
    }
}
