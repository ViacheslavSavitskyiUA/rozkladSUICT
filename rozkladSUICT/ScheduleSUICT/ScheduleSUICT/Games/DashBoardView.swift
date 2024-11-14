//
//  DashBoardView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 14.11.2024.
//

import SwiftUI

struct DashBoardView: View {
    
    @ObservedObject var game: Game
    
    var body: some View {
        HStack(spacing: 16) {
            VStack {
                Text("РАХУНОК")
                    .bold()
                    .font(.title2)
                    .foregroundColor(Color(red: 240/255, green: 224/255, blue: 213/255))
                
                Text("\(game.score)")
                    .bold()
                    .font(.title)
                    .foregroundColor(.white)
                    .animation(.easeInOut)
            }
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .background(Color(red: 187/255, green: 174/255, blue: 161/255))
            .cornerRadius(5)
            
            VStack {
                Text("НАЙКРАЩИЙ")
                    .bold()
                    .font(.title2)
                    .foregroundColor(Color(red: 240/255, green: 224/255, blue: 213/255))
                
                Text("\(game.bestScore)")
                    .bold()
                    .font(.title)
                    .foregroundColor(.white)
                    .animation(.easeInOut)
            }
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .background(Color(red: 187/255, green: 174/255, blue: 161/255))
            .cornerRadius(5)
        }
    }
}
