//
//  SelectListViewModel.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 29.09.2023.
//

import Combine

final class SelectListViewModel: ObservableObject {
    
    @Published var faculties: [FacultyModel] = []
    @Published var courses: [CourseModel] = []
    
    @Published var facultyViewModel: SelectItemViewModel
    
    let userType: UserType
    
    private let network = NetworkManager()
    
    init(userType: UserType, facultyViewModel: SelectItemViewModel = .init(inputsData: [], type: .faculty)) {
        self.userType = userType
        self.facultyViewModel = facultyViewModel
    }
    
    func fetchFaculties() async throws {
        do {
            try await faculties = network.getFaculties().get()
            await MainActor.run {
                facultyViewModel.inputsData = faculties
            }
        } catch {
            print(error)
        }
    }
    
    func fetchCourses() async throws {
        var courses: [CourseModel] = []
        do {
            try await courses = network.getCourse(facultyViewModel.selectedItem?.id ?? 0).get()
            print(courses)
        } catch {
            print(error)
        }
    }
}
