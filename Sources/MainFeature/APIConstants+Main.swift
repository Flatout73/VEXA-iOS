//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 13.06.2022.
//

import Foundation
import ApiClient
import Alamofire
import SharedModels

extension APIConstants {
    enum Content: ApiClient.Request {
        case discovery
        case search(String?, category: ContentCategory?)

        var method: HTTPMethod {
            switch self {
            case .discovery, .search:
                return .get
            case .universities:
                return .get
            }
        }

        var path: String {
            switch self {
            case .discovery:
                return "/discovery"
            case .search:
                return "/discovery/search"
            }
        }

        var paramaters: Parameters? {
            switch self {
            case .search(let text, let category):
                var params: [String: Any] = [:]
                if let text = text {
                    params["query"] = text
                }
                if let category = category {
                    params["category"] = category.rawValue
                }
                return params
            default:
                return nil
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
