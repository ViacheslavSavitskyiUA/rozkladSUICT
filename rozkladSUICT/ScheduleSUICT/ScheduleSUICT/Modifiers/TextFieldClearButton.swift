//
//  TextFieldClearButton.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 23.10.2023.
//

import SwiftUI

struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        HStack {
            content
            
            if !text.isEmpty {
                Button(
                    action: { self.text = "" },
                    label: {
                        Image(systemName: "delete.left")
                            .foregroundColor(Color(UIColor.opaqueSeparator))
                            .padding(.trailing)
                    }
                )
                .frame(width: 28, height: 17.5)
            }
        }
    }
}
