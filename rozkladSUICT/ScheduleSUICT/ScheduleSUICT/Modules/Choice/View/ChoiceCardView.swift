//
//  ChoiceCardView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 28.09.2023.
//

import SwiftUI

struct ChoiceCardView: View {
    
    @ObservedObject var viewModel: ChoiceCardViewModel
    
    private let constantSize: CGFloat = UIScreen.main.bounds.size.width / 2 - 20
    let userType: UserType
    let isHero: Bool
    
    var body: some View {
        ZStack {
            userType.backgroundColor
                .cornerRadius(16)
                .frame(width: constantSize, height: constantSize)
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(viewModel.isSelect ? userType.borderColor : .clear, lineWidth: 6)
                }
            
            VStack {
                if isHero {
                    EmptyView()
                } else {
                    LottieView(loopMode: .loop, lottieFile: userType.lottieFile.rawValue)
                        .scaleEffect(userType == .student || userType == .teacher ? 0.10 : 0.2)
                        .frame(width: 100, height: 100)
                }
                
                Text(userType.title)
                    .font(isHero ? .system(size: 18, weight: .bold) : .gilroy(.light, size: 12))
                    .foregroundStyle(isHero ? .fallGold : .black)
                    .padding(.bottom, isHero ? -4 : 4)
            }
        }
        .frame(width: constantSize, height: constantSize)
    }
}

//#Preview {
//    ChoiceCardView(viewModel: .init(), userType: .teacher)
//}
