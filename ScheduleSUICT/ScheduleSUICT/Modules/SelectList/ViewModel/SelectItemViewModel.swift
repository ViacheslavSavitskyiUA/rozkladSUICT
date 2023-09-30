//
//  SelectItemViewModel.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 29.09.2023.
//

import Combine

enum SelectItemType {
    case faculty
}

final class SelectItemViewModel: ObservableObject {
    @Published var inputsData: [FacultyModel]
    @Published var selectedItem: FacultyModel? = nil
    
    @Published var isReveal = false
    
    private let type: SelectItemType
    
    init(inputsData: [FacultyModel], type: SelectItemType) {
        self.inputsData = inputsData
        self.type = type
    }
    
    
}
