//
//  Margin.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 09.10.2023.
//

import SwiftUI
import Combine

struct MarginForList: ViewModifier {
    
    let edges: Edge.Set
    let lenghy: CGFloat?
    
    func body(content: Content) -> some View {
        if #available(iOS 17, *) {
            return content
                .contentMargins(.horizontal, 16, for: .scrollContent)
        } else {
            return content
                .padding(.horizontal, 16)
        }
    }
}

extension View {
    func margin(edges: Edge.Set = .all, _ lenght: CGFloat?) -> some View {
        modifier(MarginForList(edges: edges, lenghy: lenght))
    }
}
