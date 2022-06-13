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

        var method: HTTPMethod {
            switch self {
            case .discovery:
                return .get
            }
        }

        var path: String {
            switch self {
            case .discovery:
                return "/discovery"
            }
        }
    }
}
