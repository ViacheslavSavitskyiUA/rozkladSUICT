//
//  SelectTeacherViewModel.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 25.10.2023.
//

import Combine

class SelectTeacherViewModel: ObservableObject {
    
    private let network = NetworkManager()
    
    @Published var teachers: [ChoiceEntity] = []
    @Published var searchText = "" {
        didSet {
            isOpen = searchText.isEmpty ? false : true
        }
    }
    
    @Published var selectedItem: ChoiceEntity? = nil {
        didSet {
            if selectedItem != nil {
                completion()
            }
        }
    }
    
    private var completion: (() -> Void)
    
    @Published var isOpen: Bool = false
    
    init(action: @escaping (() -> Void)) {
        self.completion = action
    }
    
    @MainActor
    func search(teachers: String) async {
        if self.teachers.isEmpty {
            
            do {
                let models = await network.searchTeachers(name: teachers)
                
                switch models {
                case .success(let teachers):
                    self.teachers = transform(teachers: teachers)
                case .failure(let failure):
                    print(failure)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func setupItemTitle(_ item: ChoiceEntity) -> String {
        "\(item.fullName) \(item.shortName ?? "") (каф: \(item.cafedraFull ?? ""))"
    }
    
    func setupSelectItemTitle(_ item: ChoiceEntity) -> String {
        "\(item.fullName) \(item.shortName ?? "")"
    }
    
    @MainActor
    func transform(teachers: [SelectTeacherModel]) -> [ChoiceEntity] {
        var choicesEntity = [ChoiceEntity]()
        
        teachers.forEach { teacher in
            choicesEntity.append(ChoiceEntity(id: teacher.id,
                                              shortName: "\(teacher.firstName + " " + teacher.secondName)",
                                              fullName: teacher.lastName,
                                              initials: "\(teacher.firstName.first ?? "|"). \(teacher.secondName.first ?? "|").",
                                              cafedraFull: teacher.chairName))
        }
        return choicesEntity
    }
}
