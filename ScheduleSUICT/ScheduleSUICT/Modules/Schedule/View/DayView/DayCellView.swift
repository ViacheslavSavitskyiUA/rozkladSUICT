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
//                .shadow(color: viewModel.foregroundColor(), radius: 8, x: 0, y: 5)
            VStack(spacing: 8) {
                Text(viewModel.day.dayWeek)
                    .foregroundColor(.black)
                    .font(.gilroy(.light, size: 12))
                Text(viewModel.day.date)
                    .foregroundColor(.black)
                    .font(.gilroy(.light, size: 14))
            }
            .padding(4)
        }
        .frame(width: 80, height: 54)
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
}

//#Preview {
//    DayCellView(viewModel: .init(day: DayEntity(dayString: "rcf",
//                                                dateString: "dcsd",
//                                                isToday: true, dateISOString: "",
//                                                isSelected: false)),
//                selected: { _ in })
//}
