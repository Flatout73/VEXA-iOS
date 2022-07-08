//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 13.06.2022.
//

import Foundation
import ApiClient
import Alamofire

extension APIConstants {
    enum Content: ApiClient.Request {
        case discovery
        case search(String)

        var method: HTTPMethod {
            switch self {
            case .discovery, .search:
                return .get
            }
        }

        var path: String {
            switch self {
            case .discovery:
                return "/discovery"
            case .search:
                return "/search"
            }
        }

        var paramaters: Parameters? {
            switch self {
            case .search(let text):
                return ["query": text]
            default:
                return nil
            }
        }

        var encoding: ParameterEncoding {
            switch self {
            case .search:
                return URLEncodedFormParameterEncoder()
            default:
                return JSONParameterEncoder()
            }
        }
    }
}
