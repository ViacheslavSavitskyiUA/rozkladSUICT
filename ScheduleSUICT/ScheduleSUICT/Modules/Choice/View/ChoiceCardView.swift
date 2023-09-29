//
//  ChoiceCardView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 28.09.2023.
//

import SwiftUI

struct ChoiceCardView: View {
    
    @ObservedObject var viewModel: ChoiceCardViewModel
    
    private let constantSize: CGFloat = UIScreen.main.bounds.size.width - 140
    let userType: UserType
    
    var body: some View {
        ZStack {
            userType.backgroundColor
                .cornerRadius(16)
                .frame(width: constantSize, height: constantSize)
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(viewModel.isSelect ? userType.borderColor : .clear, lineWidth: 6)
                }
                
            userType.backgroundColor
                .cornerRadius(16)
                .frame(width: 200, height: 200)
            VStack {
                LottieView(loopMode: .loop, lottieFile: userType.lottieFile)
                    .scaleEffect(0.17)
                    .frame(width: 160, height: 160)
                Text(userType.title)
                    .font(.gilroy(.light, size: 12))
            }
        }
        .frame(width: constantSize, height: constantSize)
    }
}

#Preview {
    ChoiceCardView(viewModel: .init(), userType: .teacher)
}
