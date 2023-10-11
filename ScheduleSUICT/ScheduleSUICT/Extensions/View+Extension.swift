//
//  View+Extension.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 04.10.2023.
//

import SwiftUI

extension View {
    func popUpNavigationView<Content: View>(show: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        return self
            .overlay {
                if show.wrappedValue {
                    
                    GeometryReader { proxy in
                        Color.primary
                            .opacity(0.15)
                            .ignoresSafeArea()
                        
                        let size = proxy.size
                        
                        content()
                            .padding(.bottom, 44)
                            .frame(width: size.width, height: size.height / 1.7, alignment: .center)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                }
            }
    }
}
