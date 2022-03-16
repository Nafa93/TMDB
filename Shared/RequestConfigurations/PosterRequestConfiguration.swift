//
//  PosterRequestConfiguration.swift
//  TMDB (iOS)
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 15/03/2022.
//

import Foundation

struct PosterRequestConfiguration: RequestConfiguration {
    var scheme: String {
        "https"
    }
    
    var host: String {
        "image.tmdb.org"
    }
    
    var path: String {
        "/t/p/w185\(posterPath)"
    }
    
    var parameters: [URLQueryItem]? {
        nil
    }
    
    var method: MethodType {
        .GET
    }
    
    var posterPath: String
}
