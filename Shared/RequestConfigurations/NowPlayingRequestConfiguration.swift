//
//  NowPlayingRequestConfiguration.swift
//  TMDB (iOS)
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 15/03/2022.
//

import Foundation

struct NowPlayingRequestConfiguration: RequestConfiguration {
    var scheme: String {
        "https"
    }
    
    var host: String {
        "api.themoviedb.org"
    }
    
    var path: String {
        "/3/movie/now_playing"
    }
    
    var parameters: [URLQueryItem]? {
        [URLQueryItem(name: "api_key", value: "7bfe007798875393b05c5aa1ba26323e")]
    }
    
    var method: MethodType {
        .GET
    }
}
