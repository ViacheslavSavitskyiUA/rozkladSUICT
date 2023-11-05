//
//  RozkladDetailView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 30.10.2023.
//

import SwiftUI

struct RozkladDetailView: View {
    
    let lesson: LessonEntity
    let type: UserType
    
    var completion: (() -> Void)
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Назва: \(lesson.disciplineFullName)(\(lesson.disciplineShortName))")
                    .padding(.top, 16)
                    .lineLimit(4)
                Text("Тип: \(lesson.typeStr)")
                Text("Номер пари: \(lesson.lessonNumber)")
                Text("Аудиторія: \(lesson.classroom)")
                Text(type == .student ? "Викладач: \(lesson.teachersNameFull)" : "Група: \(lesson.groups)")
                Text("Час: \(lesson.timeStart) - \(lesson.timeEnd)")
            }
            .padding(.horizontal)
            
            Button {
                completion()
            } label: {
                Text("Закрити")
                    .font(.gilroy(.semibold, size: 18))
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 40, height: 60)
                    .background(Color.fallGold)
                    .foregroundColor(.white)
                    .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
            }
            .task {
                print("lesson1 \(lesson)")
            }
        }
        .background(.white)
        
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
