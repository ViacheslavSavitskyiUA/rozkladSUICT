//
//  NetworkLayer.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 29.09.2023.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum APIError: Error {
    case badURL
    case badRequest
}

enum APIEndpoints {
    case faculties
    case courses
    
    var endpointString: String {
        switch self {
        case .faculties: return "list/faculties"
        case .courses: return "list/courses"
        }
    }
}

final class NetworkClient {
    let path = "https://api.e-rozklad.dut.edu.ua/"
}

extension NetworkClient {
    
    func request<T: Codable>(endpoint: APIEndpoints,
                             method: HTTPMethod = .get,
                             urlParams: String? = nil,
                             body: [String: Any] = [:]) async throws -> Result<T, Error> {
        
        var newPath = "\(path)\(endpoint.endpointString)"
        if let urlParams = urlParams {
            newPath.append(urlParams)
        }
        
        guard let url = URL(string: newPath) else { return .failure(APIError.badRequest) }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = try! JSONSerialization.data(withJSONObject: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { return .failure(APIError.badRequest) }
        
        do {
            let decode = try JSONDecoder().decode(T.self, from: data)
            print(decode)
            return .success(decode)
        } catch {
            return .failure(error)
        }
    }
}
