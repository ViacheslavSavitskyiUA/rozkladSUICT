//
//  RozkladListViewModel.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 07.10.2023.
//

import Combine

final class RozkladCellViewModel: ObservableObject {
    @Published var discipline: String
    @Published var auditory: String
    @Published var groupAuditory: String
    
    init(discipline: String, auditory: String, groupAuditory: String) {
        self.discipline = discipline
        self.auditory = auditory
        self.groupAuditory = groupAuditory
    }
}
