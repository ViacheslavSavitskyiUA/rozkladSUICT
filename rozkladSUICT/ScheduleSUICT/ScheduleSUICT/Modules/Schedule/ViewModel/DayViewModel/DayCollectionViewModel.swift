//
//  DayCollectionViewModel.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 05.10.2023.
//

import Combine
import Foundation

final class DayCollectionViewModel: ObservableObject {
    
    @Published var days: [RozkladEntity] = []
    
    @Published var day: RozkladEntity = .init()
    
    var completion: (RozkladEntity) -> ()
    
    init(completion: @escaping (RozkladEntity) -> ()) {
        self.completion = completion
    }
    
    @MainActor
    func selected(day: RozkladEntity) {
        for (index, element) in days.enumerated() {
            days[index].isSelected = element.date == day.date ? true : false
        }
    }
}


