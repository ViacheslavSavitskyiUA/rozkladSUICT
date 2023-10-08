//
//  NetworkManager.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 29.09.2023.
//

import Foundation
import SwiftUI

struct NetworkManager {
    let network: NetworkClient
    
    init(network: NetworkClient = .init()) {
        self.network = network
    }
    
    func getFaculties() async -> Result<[FacultyModel], Error> {
        await network.request(endpoint: .faculties,
                              method: .post)
    }
    
    func getCourse(_ facultyId: Int) async -> Result<[CourseModel], Error> {
        await network.request(endpoint: .courses, 
                              method: .post,
                              body: ["facultyId" : "\(facultyId)"])
    }
    
    func getGroups(_ facultyId: Int, course: Int) async -> Result<[GroupModel], Error> {
        await network.request(endpoint: .groups,
                              method: .post,
                              body: ["facultyId" : "\(facultyId)",
                                     "course" : "\(course)"])
    }
    
    func getChairs(structureId: Int = 0, facultyId: Int) async -> Result<[ChairModel], Error> {
        await network.request(endpoint: .chairs,
                              method: .post,
                              body: ["structureId" : "\(structureId)",
                                     "facultyId" : "\(facultyId)"])
    }
    
    func getTeachers(chairId: Int) async -> Result<[TeacherModel], Error> {
        await network.request(endpoint: .teachers,
                              method: .post,
                              body: ["chairId" : "\(chairId)"])
    }
    
    func getRozklad(groupId: Int, dateStart: String, dateEnd: String) async -> Result<[RozkladModel], Error> {
        await network.request(endpoint: .groupRozklad,
                              method: .post,
                              body: ["groupId" : "\(groupId)",
                                     "dateStart" : dateStart,
                                     "dateEnd" : "\(dateEnd)"])
    }
        
        func getRozklad(teacherId: Int, dateStart: String, dateEnd: String) async -> Result<[RozkladModel], Error> {
            await network.request(endpoint: .teacherRozklad,
                                  method: .post,
                                  body: ["teacherId" : "\(teacherId)",
                                         "dateStart" : dateStart,
                                         "dateEnd" : dateEnd])
    }
}
