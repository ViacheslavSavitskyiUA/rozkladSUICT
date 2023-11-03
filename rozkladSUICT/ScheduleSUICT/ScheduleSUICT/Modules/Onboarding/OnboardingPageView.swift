//
//  OnboardingPageView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 29.10.2023.
//

import SwiftUI

enum OnboardingMediaType {
    case image(name: String)
    case lottie(name: String)
}

struct OnboardingPageView: View {
    let page: OnboardingPageModel
    let imageWidth: CGFloat = 150
    let textWidth: CGFloat = 350
    
    var body: some View {
//        let size = UIImage(named: page.imageName)?.size ?? .zero
//        let aspect = size.width / size.height
        
        return VStack(spacing: 20) {
            Text(page.title)
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundColor(page.textColor)
                .frame(width: textWidth)
                .multilineTextAlignment(.center)
            Image(page.imageName)
                .resizable()
                .frame(width: imageWidth, height: imageWidth)
                .cornerRadius(40)
                .clipped()
            VStack(alignment: .center, spacing: 5) {
                Text(page.header)
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .foregroundColor(page.textColor)
                    .frame(width: 300, alignment: .center)
                    .multilineTextAlignment(.center)
                Text(page.content)
                    .font(Font.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(page.textColor)
                    .frame(width: 300, alignment: .center)
                    .multilineTextAlignment(.center)
            }
        }
    }
    
//    @ViewBuilder func mediaView(type: OnboardingMediaType) -> some View {
//        switch type {
//        case .image(let name):
//            Image(name)
//        case .lottie(let name):
//            LottieView(loopMode: .loop, lottieFile: name)
//        }
//    }
}

#Preview {
    OnboardingPageView(page: .init(pageNumber: 1, title: "", header: "", content: "", imageName: "", color: .clear, textColor: .clear))
}
