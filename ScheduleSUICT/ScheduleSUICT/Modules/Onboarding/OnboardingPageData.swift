//
//  OnboardingPageData.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 29.10.2023.
//

import Foundation
import SwiftUI

struct OnboardingPageModel {
    let pageNumber: Int
    let title: String
    let header: String
    let content: String
    let imageName: String
    let color: Color
    let textColor: Color
}

struct OnboardingPageData {
    static let pages: [OnboardingPageModel] = [
        OnboardingPageModel(
            pageNumber: 1,
            title: "Вітаю у застосунку",
            header: "Step 1",
            content: "Break off a branch holding a few grapes and lay it on your plate.",
            imageName: "",
            color: Color(hex: "F38181"),
            textColor: Color(hex: "FFFFFF")),
        OnboardingPageModel(
            pageNumber: 2,
            title: "Eating grapes 101",
            header: "Step 2",
            content: "Put a grape in your mouth whole.",
            imageName: "screen 2",
            color: Color(hex: "FCE38A"),
            textColor: Color(hex: "4A4A4A")),
        OnboardingPageModel(
            pageNumber: 3,
            title: "Eating grapes 101",
            header: "Step 3",
            content: "Deposit the seeds into your thumb and first two fingers.",
            imageName: "screen 3",
            color: Color("95E1D3"),
            textColor: Color(hex: "4A4A4A")),
        OnboardingPageModel(
            pageNumber: 4, 
            title: "Eating grapes 101",
            header: "Step 4",
            content: "Place the seeds on your plate.",
            imageName: "screen 4",
            color: Color(hex: "EAFFD0"),
            textColor: Color(hex: "4A4A4A")),
    ]
}
