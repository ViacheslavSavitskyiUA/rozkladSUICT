//
//  View+Extension.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 04.10.2023.
//

import SwiftUI
import Combine

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
                        .frame(width: UIScreen.main.bounds.width)
//                        .frame(width: 0)
//                            .padding(.bottom, 44)
//                            .frame(width: size.width, height: size.height / 1.7, alignment: .center)
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
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

extension View {
    /// A backwards compatible wrapper for iOS 14 `onChange`
    @ViewBuilder func onValueChanged<T: Equatable>(of value: T, perform onChange: @escaping (T) -> Void) -> some View {
        if #available(iOS 14.0, *) {
            self.onChange(of: value, perform: onChange)
        } else {
            self.onReceive(Just(value)) { (value) in
                onChange(value)
            }
        }
    }
}
