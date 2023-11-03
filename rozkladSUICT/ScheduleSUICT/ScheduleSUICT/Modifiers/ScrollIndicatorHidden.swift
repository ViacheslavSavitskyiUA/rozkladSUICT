//
//  ScrollIndicatorHidden.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 11.10.2023.
//

import SwiftUI

struct ScrollIndicatorHidden: ViewModifier {
    
    func body(content: Content) -> some View {
        if #available(iOS 16, *) {
            return content
                .scrollIndicators(.hidden)
        } else {
            UITableView.appearance().showsVerticalScrollIndicator = false
            return content
        }
    }
}

extension View {
    func scrollIndicatorHidden() -> some View {
        modifier(ScrollIndicatorHidden())
    }
}
