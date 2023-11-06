//
//  OnboardingView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 29.10.2023.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        ConcentricOnboardingView(pageContents: OnboardingPageData.pages.map({ (OnboardingPageView(page: $0), $0.color) }))
            .duration(1.0)
            .nextIcon("chevron.forward")
            .animationDidEnd {}
    }
}

#Preview {
    OnboardingView()
}
