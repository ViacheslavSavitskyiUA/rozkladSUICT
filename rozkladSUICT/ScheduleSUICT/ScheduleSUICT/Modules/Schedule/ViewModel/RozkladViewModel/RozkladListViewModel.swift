//
//  RozkladListViewModel.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 07.10.2023.
//

import Combine

final class RozkladListViewModel: ObservableObject {
    
    @Published var lessons: [LessonEntity]
    
    let type: UserType
    
    init(lessons: [LessonEntity], type: UserType) {
        self.lessons = lessons
        self.type = type
    }
}
