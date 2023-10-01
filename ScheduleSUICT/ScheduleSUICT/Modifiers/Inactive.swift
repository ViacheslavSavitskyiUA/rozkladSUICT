//
//  Inactive.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 30.09.2023.
//

import SwiftUI

struct Inactive: ViewModifier {
    
    var isActive: Bool
    
    func body(content: Content) -> some View {
        content
            .disabled(isActive)
            .opacity(isActive ? 0.5 : 1)
    }
}

extension View {
    func inactive(_ isActive: Bool) -> some View {
        modifier(Inactive(isActive: isActive))
    }
}
