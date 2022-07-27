//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 30.06.2022.
//

import ApiClient
import Alamofire
import Protobuf
import Foundation

enum AuthorizationRequest: ApiClient.Request {
    case login(email: String, password: String)
    case siwa(appleToken: String, firstName: String?, lastName: String?, email: String?, imageURL: URL?)
    case google(LoginRequest)

    var method: HTTPMethod {
        switch self {
        case .login, .siwa, .google:
            return .post
        }
    }

    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .siwa:
            return "/oauth/apple"
        case .google:
            return "/oauth/google"
        }
    }

    var paramaters: RequestParams? {
        switch self {
        case .login(let email, let password):
            var paramaters: [String: Any] = [:]
            paramaters["email"] = email
            paramaters["password"] = password
            return .alamofire(paramaters, encoding: JSONEncoding())
        case let .siwa(appleToken, firstName, lastName, email, imageURL):
            var siwaRequest = SIWARequest()
            siwaRequest.firstName = firstName ?? ""
            siwaRequest.lastName = lastName ?? ""
            siwaRequest.appleIdentityToken = appleToken
            siwaRequest.imageURL = imageURL?.path ?? ""
            var loginRequest = LoginRequest()
            loginRequest.email = email ?? ""
            loginRequest.siwa = siwaRequest
            return .protobuf(loginRequest)
        case .google(let loginRequest):
            return .protobuf(loginRequest)
        }

    }


}
