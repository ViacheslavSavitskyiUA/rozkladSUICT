//
//  Lottie.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 28.09.2023.
//

import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
    
    let loopMode: LottieLoopMode
    let lottieFile: String

    func updateUIView(_ uiView: UIViewType, context: Context) { }

    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: lottieFile)
        animationView.play()
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFit
        return animationView
    }
}
