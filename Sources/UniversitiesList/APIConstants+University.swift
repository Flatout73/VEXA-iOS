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
        case search(String?)

        var method: HTTPMethod {
            switch self {
            case .fetchUniversities, .search:
                return .get
            }
        }

        var path: String {
            switch self {
            case .fetchUniversities:
                return "/universities"
            case .search:
                return "/universities/search"
            }
        }
        
        var encoding: ParameterEncoding {
            switch self {
            case .search:
                return URLEncoding()
            default:
                return JSONEncoding()
            }
        }
    }
}
