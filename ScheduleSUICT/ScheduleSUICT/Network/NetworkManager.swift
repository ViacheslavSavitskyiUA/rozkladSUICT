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
    
    func getFaculties() async throws -> Result<[FacultyModel], Error> {
        do {
            let data: Result<[FacultyModel], Error> = try await network.request(endpoint: .faculties, method: .post)
            return .success(try data.get())
        } catch {
            return .failure(error)
        }
    }
    
    func getCourse(_ facultyId: Int) async throws -> Result<[CourseModel], Error> {
        do {
            let data: Result<[CourseModel], Error> = try await network.request(endpoint: .courses, method: .post, body: ["facultyId" : facultyId])
            return .success(try data.get())
        } catch {
            return .failure(error)
        }
    }
}
