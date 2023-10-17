//
//  NetworkErrorView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 17.10.2023.
//

import SwiftUI

struct NetworkErrorView: View {
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Помилка запиту")
                .font(.gilroy(.bold, size: 28))
                .fontWeight(.bold)
            
            Text("Трапилась критична помилка запиту. Нам дуже жаль, скористуйтесь застосунком трішечки пізніше.")
                .font(.gilroy(.medium, size: 18))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            LottieView(loopMode: .loop, lottieFile: LottieFile.NetworkError.animation.rawValue)
                .scaleEffect(0.3)
                .frame(width: UIScreen.main.bounds.width / 1.5,
                       height: UIScreen.main.bounds.width / 1.5)
            
        }
    }
}

#Preview {
    NetworkErrorView()
}
