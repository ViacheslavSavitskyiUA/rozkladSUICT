//
//  HeroView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 03.10.2024.
//

import SwiftUI

struct HeroView: View {
    
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    private let entities: [HeroEntity] = heroEntities.shuffled()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.opacity(0.7)
                    .ignoresSafeArea()
                ForEach(0..<entities.count, id: \.self) { index in
                    card(entity: entities[index])
                        .frame(width: UIScreen.main.bounds.width * 0.7,
                               height: UIScreen.main.bounds.height * 0.6)
                        .cornerRadius(25)
                        .opacity(currentIndex == index ? 1.0 : 0.5)
                        .scaleEffect(currentIndex == index ? 1.2 : 0.8)
                        .offset(x: CGFloat(index - currentIndex) * ((UIScreen.main.bounds.width * 0.7) + 10) + dragOffset, y: 0)
                }
            }
            .gesture(
                DragGesture()
                    .onEnded({ value in
                        let threshould: CGFloat = 50
                        if value.translation.width > threshould {
                            withAnimation {
                                currentIndex = max(0, currentIndex - 1)
                            }
                        } else if value.translation.width < -threshould {
                            withAnimation {
                                currentIndex = min(entities.count - 1, currentIndex + 1)
                            }
                        }
                    })
        )
            .navigationTitle("На щиті")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image("backArrow")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .foregroundStyle(Color.fennelFlower)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    func card(entity: HeroEntity) -> some View {
        ZStack {
            Color.black
            
            VStack(spacing: 20) {
                Image(entity.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(16)
                    .padding(.horizontal, 24)
                    
                Text(entity.name)
                    .foregroundStyle(Color.fallGold)
                    .font(.system(size: 18, weight: .semibold))
                    
                Text(entity.dateLife)
                    .foregroundStyle(Color.fallGold)
                    .font(.system(size: 16))
            }
        }
    }
}

#Preview {
    HeroView()
}
