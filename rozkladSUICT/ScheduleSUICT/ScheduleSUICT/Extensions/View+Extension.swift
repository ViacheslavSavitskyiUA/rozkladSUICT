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
                    
                        Color.primary
                            .opacity(0.15)
                            .ignoresSafeArea()
                        
                    let size = UIScreen.main.bounds
                        
                        content()
                            .padding(.bottom, 44)
                            .frame(width: size.width, height: size.height / 1.7, alignment: .center)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
