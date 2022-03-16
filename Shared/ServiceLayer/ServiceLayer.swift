//
//  ServiceLayer.swift
//  ArtGallery (iOS)
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 22/01/2022.
//

import Foundation

final class ServiceLayer {
    private enum Errors: Error {
        case urlNotFound, invalidResponse, unsuccessfulResponse
    }
    
    class func request<T: Codable>(configuration: RequestConfiguration) async throws -> T {
        guard let url = getUrl(from: configuration) else {
            throw Errors.urlNotFound
        }
    
        var urlRequest = URLRequest(url: url)
    
        urlRequest.httpMethod = configuration.method.rawValue
    
        let session = URLSession(configuration: .default)

        let (data, response) = try await session.data(for: urlRequest)
    
        guard let httpResponse = response as? HTTPURLResponse else {
            throw Errors.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw Errors.unsuccessfulResponse
        }
        
        do {
            let decoder = SnakeCaseJSONDecoder()
            
            return try decoder.decode(T.self, from: data)
        } catch {
            throw error
        }
    }
    
    class func getUrl(from configuration: RequestConfiguration) -> URL? {
        var components = URLComponents()
        components.scheme = configuration.scheme
        components.host = configuration.host
        components.path = configuration.path
        components.queryItems = configuration.parameters
        
        return components.url
    }
}
