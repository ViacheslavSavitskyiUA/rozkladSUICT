//
//  SelectItemViewModel.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 29.09.2023.
//

import Combine

enum SelectItemType {
    case faculty, course, group, chair, teacher
    
    var defaultTitle: String {
        switch self {
        case .faculty:
            return "Оберіть інститут"
        case .course:
            return "Оберіть курс"
        case .group:
            return "Оберіть групу"
        case .chair:
            return "Оберіть кафедру"
        case .teacher:
            return "Оберіть викладача/викладачку"
        }
    }
}

final class SelectItemViewModel: ObservableObject {
    
    @Published var inputItems: [ChoiceEntity] {
        didSet {
            print(inputItems)
        }
    }
    @Published var selectedItem: ChoiceEntity? = nil {
        didSet {
            if selectedItem != nil {
                completion?()
            }
        }
    }
    
    @Published var isOpen = false
    @Published var isInactive: Bool
    
    private var defaultTitle: String
    
    private var completion: (() -> Void)?
    private let type: SelectItemType
    
    init(type: SelectItemType, inputsItem: [ChoiceEntity], isInactive: Bool, completion: (() -> Void)?) {
        defaultTitle = type.defaultTitle
        
        self.type = type
        self.inputItems = inputsItem
        self.isInactive = isInactive
        self.completion = completion
    }
    
    // MARK: - Public methods
    func setupSelectTitle() -> String {
        if selectedItem == nil {
            return defaultTitle
        } else {
            switch type {
            case .faculty, .chair:
                return "(\(selectedItem?.shortName ?? "")) \(selectedItem?.fullName ?? "")"
            case .course, .group:
                return "\(selectedItem?.fullName ?? "")"
            case .teacher:
                return "\(selectedItem?.shortName ?? "") \(selectedItem?.fullName ?? "")"
            }
        }
    }
    
    func setupItemTitle(_ item: ChoiceEntity) -> String {
        switch type {
        case .faculty, .chair:
            return "(\(item.shortName ?? "")) \(item.fullName)"
        case .course, .group:
            return "\(item.fullName)"
        case .teacher:
            return "\(item.fullName) \(item.shortName ?? "")"
        }
    }
}
