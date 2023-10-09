//
//  LoaderView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 04.10.2023.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 160, height: 160)
                .foregroundStyle(Color.white)
            
            LottieView(loopMode: .loop, lottieFile: .loader)
                .scaleEffect(0.30)
        }
    }
}

#Preview {
    LoaderView()
}
