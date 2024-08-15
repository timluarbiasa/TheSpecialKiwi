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

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView(name: filename)
        animationView.frame = view.bounds
        animationView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        animationView.contentMode = .scaleAspectFill
        view.addSubview(animationView)
        animationView.play()
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // Update the view if needed
    }
}
