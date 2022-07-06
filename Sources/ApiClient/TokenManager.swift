//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 08.06.2022.
//

import Foundation
import Alamofire
import Log
import Protobuf
import SharedModels
import Core
import JWTDecode
import Analytics

public class TokenManager: AuthenticationCredential {
    @KeychainStorage(key: "authorizationToken")
    public var authorizationToken: AuthorizationToken?
    let analyticsPrefix = "tokenManager"

    public var requiresRefresh: Bool {
        return false
        guard let accessToken = authorizationToken?.accessToken else {
            Analytics.shared.event("\(self.analyticsPrefix)_token_missing_incorrect")
            return true
        }
        guard let jwtDecoded = try? decode(jwt: accessToken) else {
            return true
        }
        let isExpired = jwtDecoded.expired
        if isExpired {
            Analytics.shared.event("\(self.analyticsPrefix)_token_expired")
        }
        return isExpired
    }

    public init() {
    }
}
