//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 30.06.2022.
//

import ApiClient
import Alamofire

enum AuthorizationRequest: ApiClient.Request {
    case login(email: String, password: String)

    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        }
    }

    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        }
    }
}
