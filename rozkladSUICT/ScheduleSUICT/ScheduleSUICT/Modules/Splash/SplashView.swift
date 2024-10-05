//
//  SplasView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 02.11.2023.
//

import SwiftUI

struct SplashView: View {
    
    @ObservedObject var viewModel: SplashViewModel
    
    var body: some View {
        showChoiceView(isShow: viewModel.isShow)
            .task {
                
                if StorageService.readIsFirstLounch() == false {
                    
                } else {
                    UserDefaults.resetDefaults()
                    StorageService.firstLounch(false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .random(in: 0.3...2.0), execute: {
                    viewModel.isShow = true
                })
            }
    }
    
    @ViewBuilder func showChoiceView(isShow: Bool) -> some View {
        switch isShow {
        case true:
            ChoiceView(viewModel: .init())
        case false:
            Image("splashScreenLogo")
                .resizable()
                .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2)
        }
    }
}

#Preview {
    SplashView(viewModel: .init())
}
