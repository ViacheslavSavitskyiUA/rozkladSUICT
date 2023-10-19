//
//  SavePopUpView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 19.10.2023.
//

import SwiftUI

enum SavePopUpType {
    case save, remove
}

struct SavePopUpView: View {
    
    let savePopUpType: SavePopUpType
    let allow: () -> ()
    let cancel: () -> ()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .padding(.horizontal)
                .foregroundStyle(Color.white)
                VStack(spacing: 20) {
                    LottieView(loopMode: .loop,
                               lottieFile: savePopUpType == .save
                               ? LottieFile.SavePopUp.checkmark.rawValue
                               : LottieFile.SavePopUp.crissCross.rawValue)
                    .scaleEffect(savePopUpType == .save ? 0.22 : 0.12)
                    .frame(width: 80, height: 80)
                    .padding(.top)
                    
                    Text(savePopUpType == .save ? "Запамʼятати?" : "Забути?")
                        .font(.gilroy(.bold, size: 20))
                    
                    Text(savePopUpType == .save
                         ? "Чи відкривати цей розклад при майбутніх входах у застосунок?"
                         : "Не відкривати цей розклад при майбутніх входах у застосунок?")
                    .font(.gilroy(.medium, size: 16))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    
                    HStack {
                        Button(action: { allow() }, label: {
                            Text(savePopUpType == .save ? "Запамʼятати" : "Забути")
                                .font(.gilroy(.semibold, size: 16))
                                .foregroundStyle(savePopUpType == .save ? Color.green : Color.red)
                                .frame(width: 120)
                                .padding(.vertical)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8.0)
                                        .stroke(savePopUpType == .save ? Color.green : Color.red, lineWidth: 3)
                                    )
                        })
                        
                        Spacer()
                            .frame(width: 30)
                        
                        Button(action: { cancel() }, label: {
                            Text("Відмінити")
                                .font(.gilroy(.semibold, size: 16))
                                .foregroundStyle(Color.fennelFlower)
                                .frame(width: 120)
                                .padding(.vertical)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8.0)
                                        .stroke(Color.fennelFlower,
                                                lineWidth: 3)
                                    )
                        })
                        
                    }

                }
                .padding([.horizontal, .bottom], 30)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    SavePopUpView(savePopUpType: .remove, allow: {}, cancel: { })
}
