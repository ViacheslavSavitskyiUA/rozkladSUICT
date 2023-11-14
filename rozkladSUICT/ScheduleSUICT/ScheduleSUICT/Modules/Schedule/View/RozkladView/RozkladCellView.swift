//
//  RozkladListView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 07.10.2023.
//

import SwiftUI

struct RozkladCellView: View {
    
    @ObservedObject var viewModel: RozkladCellViewModel
    
    var body: some View {
        
        HStack {
            VStack {
                Text("\(viewModel.lesson.lessonNumber) пара")
                    .font(.gilroy(.light, size: 14))
                    .fontWeight(.light)
                    .padding(.top, 4)
                Divider()
                    .frame(width: 60, height: 2)
                
                Spacer()
                    .frame(height: 16)
                
                Text(viewModel.lesson.timeStart)
                    .font(.gilroy(.light, size: 14))
                    .fontWeight(.light)
                
                Capsule()
                    .fill(Color.pastelFirstSnow)
                    .frame(width: 4)
                
                Text(viewModel.lesson.timeEnd)
                    .font(.gilroy(.light, size: 14))
                    .fontWeight(.light)
            }
            .padding(.horizontal, 20)
            
            ZStack {
                Rectangle()
                    .cornerRadius(12)
                    .foregroundStyle(viewModel.setupBackground())
                    .padding(.horizontal, 20)
                
                HStack {
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text("\(viewModel.lesson.disciplineShortName)[\(viewModel.lesson.typeStr)]")
                            .font(.gilroy(.medium, size: 20))
                            .fontWeight(.semibold)
                        
                        Text(viewModel.type == .auditory ? "\(viewModel.lesson.teachersName)" : "ауд. \(viewModel.lesson.classroom)")
                            .font(.gilroy(.medium, size: 16))
                        
                        Text("\(viewModel.type == .student ? viewModel.lesson.teachersName : viewModel.lesson.groups)")
                            .font(.gilroy(.medium, size: 16))
                    }
                    .padding(.vertical, 20)
                    Spacer()
                    Image("arrow")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 12,
                               height: 12)
                        
                }
                .padding(.horizontal,
                         40)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    RozkladCellView(viewModel: .init(lesson: .init(lessonNumber: 3, disciplineFullName: "PRMddddddddddd", disciplineShortName: "PRM", classroom: "325", timeStart: "11.45", timeEnd: "13:20", teachersName: "Savitskyi", teachersNameFull: "Sav Vich Andr", groups: "PDM-31", type: 0, typeStr: "Lec"), type: .student))
        .previewLayout(.sizeThatFits)
}


