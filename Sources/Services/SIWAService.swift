//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 22.07.2022.
//

import Foundation
import AuthenticationServices

public class SIWAService {

    public init() {
        
    }

    public func handleLogin(for authorization: ASAuthorization) -> ASAuthorizationAppleIDCredential? {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            return appleIDCredential
        default:
            break
        }

        return nil
    }
}
