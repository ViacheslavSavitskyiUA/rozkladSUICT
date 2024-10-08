//
//  FloatingButton.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 04.10.2024.
//

import SwiftUI

struct FloatingButton<Label: View>: View {
    
    var buttonSize: CGFloat
    var actions: [FloatingAction]
    var label: (Bool) -> Label
    
    init(buttonSize: CGFloat = 50, @FloatingActionBuilder actions: @escaping () -> [FloatingAction], @ViewBuilder label: @escaping (Bool) -> Label) {
        self.buttonSize = buttonSize
        self.actions = actions()
        self.label = label
    }
    
    @State private var isExpended: Bool = false
    
    var body: some View {
        Button {
            isExpended.toggle()
        } label: {
            label(isExpended)
                .frame(width: buttonSize, height: buttonSize)
                .contentShape(.rect)
        }
        .buttonStyle(NoAnimationButtonStyle())
        .background {
            ZStack(content: {
                ForEach(actions) { action in
                    ActionView(action)
                }
            })
        }
        .animation(.snappy(duration: 0.4, extraBounce: 0), value: isExpended)
    }
    
    @ViewBuilder
    func ActionView(_ action: FloatingAction) -> some View {
        Image(systemName: action.symbol)
            .font(action.font)
            .foregroundStyle(action.tint)
            .frame(width: buttonSize, height: buttonSize)
            .background(action.background, in: .circle)
            .contentShape(.circle)
            .rotationEffect(.init(degrees: progress(action) * -90))
            .offset(x: isExpended ? -offset / 2 : 0)
            .rotationEffect(.init(degrees: progress(action) * 90))
    }
    
    private var offset: CGFloat {
        let buttonSize = buttonSize + 10
        return Double(actions.count) * buttonSize
    }
    
    private func progress(_ action: FloatingAction) -> CGFloat {
        let index = CGFloat(actions.firstIndex(where: { $0.id == action.id }) ?? 0)
        return index / CGFloat(actions.count - 1)
    }
}

fileprivate struct NoAnimationButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

struct FloatingAction: Identifiable {
    private(set) var id: UUID = .init()
    var symbol: String
    var font: Font = .title3
    var tint: Color = .white
    var background: Color = .black
    var action: () -> ()
}

@resultBuilder
struct FloatingActionBuilder {
    static func buildBlock(_ components: FloatingAction...) -> [FloatingAction] {
        components.compactMap({ $0 })
    }
}


//#Preview {
//    FloatingButton()
//}
