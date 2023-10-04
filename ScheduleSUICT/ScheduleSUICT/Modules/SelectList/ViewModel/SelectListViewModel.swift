//
//  SelectListViewModel.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 29.09.2023.
//

import Combine

final class SelectListViewModel: ObservableObject {
    
    // MARK: - For all
    @Published var faculties: [FacultyModel] = []
    @Published var facultyViewModel: SelectItemViewModel!
    
    // MARK: - For student
    @Published var courses: [CourseModel] = []
    @Published var groups: [GroupModel] = []
    
    @Published var courseViewModel: SelectItemViewModel!
    @Published var groupViewModel: SelectItemViewModel!
    
    // MARK: - For teacher
    @Published var chairs: [ChairModel] = []
    @Published var teachers: [TeacherModel] = []
    
    @Published var chairViewModel: SelectItemViewModel!
    @Published var teacherViewModel: SelectItemViewModel!
    
    @Published var isActiveNextButton = false
    
    @Published var isShowLoader = false
    
    let userType: UserType
    
    private let network = NetworkManager()
    
    init(userType: UserType) {
        self.userType = userType
        self.setupViewModels(type: userType)
    }
}

// MARK: - Requests
extension SelectListViewModel {
    @MainActor
    func fetchFaculties() async {
        isShowLoader = true
        let models = await network.getFaculties()
        isShowLoader = false
        
        switch models {
        case .success(let faculties):
            facultyViewModel.inputItems = transform(faculties: faculties)
        case .failure(let error):
            print(error)
        }
    }
    
    @MainActor
    private func fetchCourses() async {
        isShowLoader = true
        let models = await network.getCourse(facultyViewModel.selectedItem?.id ?? 0)
        isShowLoader = false
        
        switch models {
        case .success(let courses):
            courseViewModel.inputItems = transform(courses: courses)
        case .failure(let error):
            print(error)
        }
    }
    
    @MainActor
    private func fetchGroups() async {
        isShowLoader = true
        let models = await network.getGroups(facultyViewModel.selectedItem?.id ?? 0,
                                             course: courseViewModel.selectedItem?.id ?? 0)
        isShowLoader = false
        
        switch models {
        case .success(let groups):
            groupViewModel.inputItems = transform(groups: groups)
        case .failure(let error):
            print(error)
        }
    }
    
    @MainActor
    private func fetchChairs() async {
        isShowLoader = true
        let models = await network.getChairs(facultyId: facultyViewModel.selectedItem?.id ?? 0)
        isShowLoader = false
        
        switch models {
        case .success(let chairs):
            chairViewModel.inputItems = transform(chairs: chairs)
        case .failure(let error):
            print(error)
        }
    }
    
    @MainActor
    private func fetchTeachers() async {
        isShowLoader = true
        let models = await network.getTeachers(chairId: chairViewModel.selectedItem?.id ?? 0)
        isShowLoader = false
        
        switch models {
        case .success(let teachers):
            teacherViewModel.inputItems = transform(teachers: teachers)
        case .failure(let error):
            print(error)
        }
    }
}

// MARK: Private
private extension SelectListViewModel {
    func setupViewModels(type: UserType) {
        self.facultyViewModel = .init(type: .faculty,
                                      inputsItem: [],
                                      isInactive: false,
                                      completion: { [self] in
            Task {
                switch type {
                case .student:
                    await fetchCourses()
                    courseViewModel.isInactive = false
                case .teacher:
                    await fetchChairs()
                    chairViewModel.isInactive = false
                case .unowned: ()
                }
            }
            
            setupChoicesView(type: .faculty)
        })
        
        switch type {
        case .student:
            self.courseViewModel = .init(type: .course,
                                         inputsItem: [],
                                         isInactive: true,
                                         completion: { [self] in
                Task {
                    await fetchGroups()
                }
                setupChoicesView(type: .course)
                groupViewModel.isInactive = false
                
            })
            
            self.groupViewModel = .init(type: .group,
                                        inputsItem: [],
                                        isInactive: true,
                                        completion: { [self] in
                setupChoicesView(type: .group)
            })
        case .teacher:
            self.chairViewModel = .init(type: .chair,
                                        inputsItem: [],
                                        isInactive: true,
                                        completion: { [self] in
                Task {
                    await fetchTeachers()
                }
                setupChoicesView(type: .chair)
                teacherViewModel.isInactive = false
            })
            
            self.teacherViewModel = .init(type: .teacher,
                                          inputsItem: [],
                                          isInactive: true,
                                          completion: { [self] in
                setupChoicesView(type: .teacher)
            })
        default: ()
        }
    }
    
    @MainActor
    func transform(faculties: [FacultyModel]) -> [ChoiceEntity] {
        var choicesEntity = [ChoiceEntity]()
        
        faculties.forEach { faculty in
            choicesEntity.append(ChoiceEntity(id: faculty.id,
                                              shortName: faculty.shortName,
                                              fullName: faculty.fullName))
        }
        return choicesEntity
    }
    
    @MainActor
    func transform(courses: [CourseModel]) -> [ChoiceEntity] {
        var choicesEntity = [ChoiceEntity]()
        
        courses.forEach { course in
            choicesEntity.append(ChoiceEntity(id: course.course,
                                              shortName: nil,
                                              fullName: String(course.course)))
        }
        return choicesEntity
    }
    
    @MainActor
    func transform(groups: [GroupModel]) -> [ChoiceEntity] {
        var choicesEntity = [ChoiceEntity]()
        
        groups.forEach { group in
            choicesEntity.append(ChoiceEntity(id: group.id,
                                              shortName: nil,
                                              fullName: group.name))
        }
        return choicesEntity
    }
    
    @MainActor
    func transform(chairs: [ChairModel]) -> [ChoiceEntity] {
        var choicesEntity = [ChoiceEntity]()
        
        chairs.forEach { chair in
            choicesEntity.append(ChoiceEntity(id: chair.id,
                                              shortName: chair.shortName,
                                              fullName: chair.fullName))
        }
        return choicesEntity
    }
    
    @MainActor
    func transform(teachers: [TeacherModel]) -> [ChoiceEntity] {
        var choicesEntity = [ChoiceEntity]()
        
        teachers.forEach { teacher in
            choicesEntity.append(ChoiceEntity(id: teacher.id,
                                              shortName: "\(teacher.firstName + " " + teacher.secondName)",
                                              fullName: teacher.lastName))
        }
        return choicesEntity
    }
    
    func setupChoicesView(type: SelectItemType) {
        switch type {
        case .faculty:
            switch userType {
            case .student:
                courseViewModel.isOpen = false
                courseViewModel.selectedItem = nil
                courseViewModel.isInactive = true
                
                groupViewModel.isOpen = false
                groupViewModel.selectedItem = nil
                groupViewModel.isInactive = true
                
                isActiveNextButton = false
            case .teacher:
                chairViewModel.isOpen = false
                chairViewModel.selectedItem = nil
                chairViewModel.isInactive = true
                
                teacherViewModel.isOpen = false
                teacherViewModel.selectedItem = nil
                teacherViewModel.isInactive = true
                
                isActiveNextButton = false
            case .unowned: ()
            }
        case .course:
            groupViewModel.isOpen = false
            groupViewModel.selectedItem = nil
            groupViewModel.isInactive = true
            
            isActiveNextButton = false
        case .chair:
            teacherViewModel.isOpen = false
            teacherViewModel.selectedItem = nil
            teacherViewModel.isInactive = true
            
            isActiveNextButton = false
        case .group, .teacher:
            isActiveNextButton = true
        }
    }
}
