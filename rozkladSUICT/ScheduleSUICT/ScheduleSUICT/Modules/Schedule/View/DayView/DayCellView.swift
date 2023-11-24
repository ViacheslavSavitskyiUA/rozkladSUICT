//
//  DayCellView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 05.10.2023.
//

import SwiftUI

struct DayCellView: View {
    
    @ObservedObject var viewModel: DayCellViewModel
    
    var selected: (RozkladEntity) -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(viewModel.foregroundColor())
                .cornerRadius(8)

            VStack(spacing: 8) {
                Text(viewModel.day.dayWeek.capitalized)
                    .foregroundColor(.black)
                    .font(.gilroy(.light, size: 12))
                Text(viewModel.transformDate())
                    .foregroundColor(.black)
                    .font(.gilroy(.light, size: 14))
            }
            .padding(4)
            
            haveLessons(!viewModel.day.lessons.isEmpty)
        }
        .frame(width: 94, height: 54)
        .onTapGesture {
            viewModel.day.isSelected = true
            selected(viewModel.day)
        }
        .overlay {
            if viewModel.day.isSelected {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.fennelFlower, lineWidth: 2)
            }
        }
    }
    
    @ViewBuilder func haveLessons(_ hasLessons: Bool) -> some View {
        switch hasLessons {
        case true:
            VStack {
                HStack {
                    Spacer()
                    Circle()
                        .frame(width: 8)
                        .foregroundStyle(Color.fallGold)
                        .padding([.top, .trailing], 4)
                }
                .padding(.bottom, 42)
            }
        case false:
            EmptyView()
        }
    }
}

#Preview {
    DayCellView(viewModel: .init(day: .init(date: "20.20.2020", dayWeek: "понеділок", isToday: false, isSelected: false, lessons: []))) { _ in
        
    }
}
