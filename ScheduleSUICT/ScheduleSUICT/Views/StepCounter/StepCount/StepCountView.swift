//
//  StepCountView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 30.09.2023.
//

import SwiftUI

struct StepCountView: View {
    
    @ObservedObject var viewModel: StepCountViewModel
    
    var body: some View {
        HStack {
            Circle()
                .stroke(.red, lineWidth: 2)
                .frame(width: 30)
                .background(Circle().foregroundStyle(Color.green))
                .overlay {
                    Text("1")
                }
            
        }
    }
}

#Preview {
    StepCountView(viewModel: .init())
}
