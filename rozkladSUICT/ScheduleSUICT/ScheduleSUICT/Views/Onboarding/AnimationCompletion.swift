//
//  AnimationCompletion.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 29.10.2023.
//

import SwiftUI

struct AnimationCompletionObserverModifier<Value>: AnimatableModifier where Value: VectorArithmetic {
    
    var animatableData: Value {
        didSet { notifyCompletion() }
    }
    
    private var targetValue: Value
    private var completion: () -> Void = { }
    
    init(observedValue: Value, completion: @escaping () -> Void = { }) {
        self.completion = completion
        self.animatableData = observedValue
        targetValue = observedValue
    }
    
    func body(content: Content) -> some View {
        return content
    }
    
    // MARK: - Private
    
    private func notifyCompletion() {
        if animatableData == targetValue {
            DispatchQueue.main.async { completion() }
        }
    }
}


extension View {
    
    func onAnimationCompleted<Value: VectorArithmetic>(for value: Value, completion: @escaping () -> Void) -> ModifiedContent<Self, AnimationCompletionObserverModifier<Value>> {
        return modifier(AnimationCompletionObserverModifier(observedValue: value, completion: completion))
    }
}
