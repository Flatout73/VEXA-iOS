//
//  File.swift
//  
//
//  Created by Егор on 07.07.2022.
//

import Foundation
import ApiClient
import Alamofire

extension APIConstants {
    enum Universities: ApiClient.Request {
        case fetchUniversities

        var method: HTTPMethod {
            switch self {
            case .fetchUniversities:
                return .get
            }
        }

        var path: String {
            switch self {
            case .fetchUniversities:
                return "/universities"
            }
        }
    }
}
