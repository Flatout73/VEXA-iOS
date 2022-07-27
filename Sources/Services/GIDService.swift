//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 27.07.2022.
//

import Foundation
@_implementationOnly import GoogleSignIn
import UIKit
import Protobuf

public class GIDService {
    let signInConfig = GIDConfiguration(clientID: "138529411586-cc6432of7p6q4rk37hpfsb33t5mn4pd5.apps.googleusercontent.com")

    public init() {

    }

    func handleGoogle(url: URL) {
        GIDSignIn.sharedInstance.handle(url)
    }

    func restorePrevious() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
              // Show the app's signed-out state.
            } else {
              // Show the app's signed-in state.
            }
          }
    }

    public func handleSignInButton(presentingViewController: UIViewController?) async throws -> Protobuf.LoginRequest {
        try await withCheckedThrowingContinuation { continuation in
            var loginRequest = LoginRequest()
            GIDSignIn.sharedInstance.signIn(
                with: signInConfig,
                presenting: presentingViewController ?? UIViewController()) { user, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else if let user = user {
                        let emailAddress = user.profile?.email
                        loginRequest.email = emailAddress ?? ""

                        user.authentication.do { authentication, error in
                            if let error = error {
                                continuation.resume(throwing: error)
                            } else if let authentication = authentication, let idToken = authentication.idToken {
                                var googleRequest = GoogleRequest()
                                googleRequest.idToken = idToken
                                loginRequest.google = googleRequest

                                continuation.resume(returning: loginRequest)
                            }
                        }
                    }
                }
        }
    }

    public func signOut() {
      GIDSignIn.sharedInstance.signOut()
    }
}
