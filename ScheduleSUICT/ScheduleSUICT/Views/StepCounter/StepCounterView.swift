//
//  StepCounterView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 30.09.2023.
//

import SwiftUI

struct StepCounterView: View {
    
    @ObservedObject var viewModel: StepCounterViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    StepCounterView(viewModel: .init())
}
