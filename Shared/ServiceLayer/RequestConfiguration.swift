//
//  RequestConfiguration.swift
//  ArtGallery (iOS)
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 22/01/2022.
//

import Foundation

protocol RequestConfiguration {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var parameters: [URLQueryItem]? { get }
    var method: MethodType { get }
}
