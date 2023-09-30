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
    let lottieFile: LottieFile

    func updateUIView(_ uiView: UIViewType, context: Context) { }

    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: lottieFile.fileName)
        animationView.play()
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFit
        return animationView
    }
}
