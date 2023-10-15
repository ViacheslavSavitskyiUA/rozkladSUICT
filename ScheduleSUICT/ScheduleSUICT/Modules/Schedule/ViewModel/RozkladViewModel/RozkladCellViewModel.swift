//
//  RozkladListViewModel.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 07.10.2023.
//

import Combine

final class RozkladCellViewModel: ObservableObject {
    
    @Published var lesson: LessonEntity
    
    init(lesson: LessonEntity) {
        self.lesson = lesson
    }
}
