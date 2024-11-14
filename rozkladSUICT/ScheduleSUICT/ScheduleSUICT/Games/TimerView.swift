//
//  TimerView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 14.11.2024.
//

import SwiftUI

struct TimerView: View {
    
    @ObservedObject var game: Game
    
    var geometry: GeometryProxy
    
    var body: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .frame(height: 40)
                .foregroundColor(Color(red: 240/255, green: 224/255, blue: 213/255))
            
            Capsule()
                .frame(width: (geometry.size.width-32)*CGFloat(Double(game.gameTimeLast)/120.0), height: 40)
                .foregroundColor(Color(red: 236/255, green: 140/255, blue: 85/255))
                .overlay(alignment: .trailing) {
                    if game.gameTimeLast > 15 {
                        Text("\(game.gameTimeLast)")
                            .bold()
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.trailing, 8)
                            .animation(.easeInOut)
                    }
                }
        }
        .overlay(alignment: .leading) {
            if game.gameTimeLast <= 15 {
                Text("\(game.gameTimeLast)")
                    .bold()
                    .font(.title)
                    .foregroundColor(Color(red: 120/255, green: 111/255, blue: 102/255))
                    .padding(.leading, 8)
                    .animation(.easeInOut)
            }
        }
    }
}
