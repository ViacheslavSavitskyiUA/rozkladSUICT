//
//  EmptyLessonsView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 15.10.2023.
//

import SwiftUI

struct EmptyLessonsView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.black.opacity(0.9))
                .cornerRadius(16)
                .padding(20)
            VStack {
                Text("Немає занять")
                    .font(.gilroy(.bold, size: 28))
                    .foregroundStyle(Color.fallGold.opacity(0.7))
                    .padding(.bottom, 40)
                
                ZStack {
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width / 1.4, height: UIScreen.main.bounds.width / 1.4)
                        .foregroundStyle(Color.white)
                        .cornerRadius(16)
                    
                    LottieView(loopMode: .loop,
                               lottieFile: (LottieFile.EmptyLessons.allCases.randomElement()
                                            ?? .a1).rawValue)
                    .scaleEffect(0.2)
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width / 1.45, height: UIScreen.main.bounds.width / 1.45)
                }
            }
            
        }
    }
}

#Preview {
    EmptyLessonsView()
}
