//
//  EmptyLessonsView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 15.10.2023.
//

import SwiftUI

struct EmptyLessonsView: View {
    var body: some View {
        ZStack(content: {
            Rectangle()
                .foregroundStyle(Color.pastelFirstSnow)
                .cornerRadius(16)
                .padding(20)
            
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
        })
    }
}

#Preview {
    EmptyLessonsView()
}
