//
//  LoaderView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 03.10.2023.
//

import Foundation
import SwiftUI

struct LoaderView<Content>: View where Content: View {

    @Binding var isShowing: Bool
 
    var content: () -> Content
    
    // MARK:- views
    var body: some View {
        ZStack(alignment: .center) {
            
            self.content()
                .disabled(self.isShowing)
            
            BlurView(radius: 5)
                .opacity(isShowing ? 1 : 0)
            
            ZStack {
                LottieView(loopMode: .loop, lottieFile: .loader)
            }
            .frame(width: 80, height: 80)
            .opacity(isShowing ? 1 : 0)
        }
    }
}

#Preview {
    LoaderView(isShowing: .constant(true)) {
        NavigationView {
            List(["1", "2", "3", "4", "5"], id: \.self) { row in
                Text(row)
            }.navigationBarTitle(Text("Loader Test"), displayMode: .large)
        }
    }
}


//BlurView
struct BlurView: View {
    let radius: CGFloat
    
    @ViewBuilder
    var body: some View {
        BackdropView().blur(radius: radius)
    }
}

//MARK: Blur
struct BackdropView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView()
        let blur = UIBlurEffect(style: .extraLight)
        
        let animator = UIViewPropertyAnimator()
        animator.addAnimations { view.effect = blur }
        animator.fractionComplete = 0
        animator.stopAnimation(true)
        animator.finishAnimation(at: .start)
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) { }
}
