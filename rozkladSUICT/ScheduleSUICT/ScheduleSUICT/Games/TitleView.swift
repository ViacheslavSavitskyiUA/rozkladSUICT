//
//  TitleView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 14.11.2024.
//

import SwiftUI

struct TitleView: View {
    
    @ObservedObject var game: Game
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        HStack(spacing: 8) {
            
            Button {
                mode.wrappedValue.dismiss()
            } label: {
                Image("backArrow")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color.fennelFlower)
            }
            
            Spacer()
            
            Button {
                game.timerStop()
            } label: {
                Image(systemName: "pause.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(red: 236/255, green: 140/255, blue: 85/255))
            }
        }
    }
}
