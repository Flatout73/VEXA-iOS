//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 06.07.2022.
//

import ApiClient
import Alamofire

enum ProfileRequest: ApiClient.Request {
    case me

    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }

    var path: String {
        switch self {
        case .me:
            return "/students/me"
        }
    }

    var paramaters: Parameters? {
        return nil
    }
}
