//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 13.06.2022.
//

import Foundation

enum ServerError: LocalizedError {
    case parsing
    case server(String)
    case array

    var errorDescription: String? {
        switch self {
        case .parsing:
            return "Parsing"
        case .server(let error):
            return error
        case .array:
            return "Wrong response format"
        }
    }
}
