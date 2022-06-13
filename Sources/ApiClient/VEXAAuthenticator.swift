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
import SwiftProtobuf
import SharedModels

class VEXAAuthenticator: Authenticator {
    typealias Credential = TokenManager

    let analyticsPrefix = "authenticator"

    func apply(_ credential: Credential, to urlRequest: inout URLRequest) {
        if let token = credential.authorizationToken?.accessToken {
            urlRequest.headers.add(.authorization(token))
        }
    }

    func refresh(_ credential: Credential, for session: Session, completion: @escaping (Result<Credential, Swift.Error>) -> Void) {
        completion(.success(credential))
//        Task(priority: .high) {
//            let request: URLRequest
//            if let token = credential.authorizationToken {
//                VEXALogger.shared.info("Trying refresh token = \(token)")
//                request = try refreshRequest(for: token)
//            } else {
//                request = try loginRequest(email: "", password: "")
//                VEXALogger.shared.info("Trying login")
//            }
//
//            let response = await Session.default.request(request)
//                .validate()
//                .serializingString()
//                .response
//
//            let result = response.result

//            switch result {
//                case .success(let authResponseString):
//                let
//                    let token = AuthorizationToken(accessToken: authResponse.accessToken, refreshToken: authResponse.refreshToken, centrifugoToken: authResponse.centrifugoToken)
//                    credential.authToken = token
//
//                    VEXALogger.shared.loggerStore.storeRequest(request,
//                                                                response: response.response,
//                                                                error: response.error?.underlyingError,
//                                                                data: response.data,
//                                                                metrics: response.metrics,
//                                                                session: Session.default.session)
//
//                    await delegate?.userDidUpdate(user: authResponse.user)
//                    if request.url?.path == APIConstants.Auth.login.path {
//                        Analytics.shared.event("\(self.analyticsPrefix)_anon_login")
//                        await delegate?.userDidLogin()
//                    } else {
//                        Analytics.shared.event("\(self.analyticsPrefix)_token_refreshed",
//                                               params: [
//                                                "token": credential.authToken?.accessToken ?? "no token",
//                                                "mainAccount": authResponse.user.mainAccount ?? "nil"
//                                               ])
//                    }
//                    completion(.success(credential))
//                case .failure(let error):
//                    WylsaLogger.shared.loggerStore.storeRequest(request,
//                                                                response: response.response,
//                                                                error: error,
//                                                                data: response.data,
//                                                                metrics: response.metrics,
//                                                                session: Session.default.session)
//
//                    if request.url?.path == APIConstants.Auth.login.path {
//                        WylsaLogger.shared.error("Fail to load anon user due to error: \(error.localizedDescription)")
//                        Analytics.shared.error(AnalyticsError(for: AnalyticSubjects.Error.Auth.anon,
//                                                                 with: error.localizedDescription))
//                    } else {
//                        WylsaLogger.shared.error("Fail to refresh user due to error: \(error.localizedDescription))")
//                        if let data = response.data, let stringResponse = String(data: data, encoding: .utf8) {
//                            WylsaLogger.shared.error(stringResponse)
//                        }
//                        Analytics.shared.error(AnalyticsError(for: "\(self.analyticsPrefix)_token_refresh_failed",
//                                                                 with: error.localizedDescription))
//                    }
//                    credential.authToken = nil
//                    await delegate?.userDidLogout()
//                    completion(.failure(error as Error))
//            }
 //       }
    }

    func didRequest(_ urlRequest: URLRequest, with response: HTTPURLResponse, failDueToAuthenticationError error: Swift.Error) -> Bool {
        return response.statusCode == 401
    }

    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: Credential) -> Bool {
        return true //urlRequest.headers["Authorization"] == credential.authorizationToken?.accessToken
    }

    private func refreshRequest(for token: AuthorizationToken) throws -> URLRequest {
        let apiURL = URL(string: APIConstants.Auth.refresh)!
        var request = URLRequest(url: apiURL)
        request.httpMethod = "POST"
        var tokenRequest = AccessTokenRequest()
        tokenRequest.refreshToken = token.refreshToken
        let jsonData = try tokenRequest.jsonUTF8Data()
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }

    private func loginRequest(email: String, password: String) throws -> URLRequest {
        let apiURL = URL(string: APIConstants.Auth.login)!
        var request = URLRequest(url: apiURL)
        request.httpMethod = "POST"
        var loginRequest = LoginRequest()
        loginRequest.email = email
        loginRequest.password = password
        request.httpBody = try loginRequest.jsonUTF8Data()
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}
