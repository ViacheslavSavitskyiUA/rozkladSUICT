//
//  RozkladListViewModel.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 07.10.2023.
//

import Combine

final class RozkladCellViewModel: ObservableObject {
    
    @Published var lesson: LessonEntity
    let type: UserType
    
    init(lesson: LessonEntity, type: UserType) {
        self.lesson = lesson
        self.type = type
    }
}
