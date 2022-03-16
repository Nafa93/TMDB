//
//  SortingType.swift
//  TMDB (iOS)
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 15/03/2022.
//

import Foundation

enum SortingType {
    case ascending, descending, noOrder
    
    func validate(firstVote: Float, secondVote: Float) -> Bool {
        switch self {
        case .ascending:
            return firstVote < secondVote
        case .descending:
            return firstVote > secondVote
        case .noOrder:
            return false
        }
    }
}
