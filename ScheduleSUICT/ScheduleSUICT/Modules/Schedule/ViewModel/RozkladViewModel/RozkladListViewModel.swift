//
//  RozkladListViewModel.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 07.10.2023.
//

import Combine

final class RozkladListViewModel: ObservableObject {
    
    @Published var days: [RozkladEntity] = [] {
        didSet {
            print("days \(days)")
        }
    }
    
    init(days: [RozkladEntity]) {
        self.days = days
    }
}
