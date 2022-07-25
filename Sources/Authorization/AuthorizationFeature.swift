import Foundation
import SwiftUI
import ComposableArchitecture
import SharedModels
import Services
import ApiClient
import Core
import Protobuf
import AuthenticationServices

public struct AuthorizationState: Equatable {
    public var alert: AlertState<AuthorizationAction.AlertAction>?

    var login = "test@test.ru"
    var password = "123456"

    public var isLoading = false

    var token: AuthorizationToken?

    public init() {

    }
}

public enum AuthorizationAction: Equatable {
    case alert(AlertAction)
    case showError(String)
    case changeLogin(String)
    case changePassword(String)
    case login
    case updateCachedToken(AuthorizationToken)

    case handleSIWALogin(ASAuthorization)

    public enum AlertAction: Equatable {
        case dismiss
        case go(String)
    }
}

public struct AuthorizationEnvironment {
    let apiClient: APIClient
    let tokenManager: TokenManager
    let userService: UserService

    public init(apiClient: APIClient, tokenManager: TokenManager, userService: UserService) {
        self.apiClient = apiClient
        self.tokenManager = tokenManager
        self.userService = userService
    }
}

public let authorizationReducerCore = Reducer<AuthorizationState, AuthorizationAction, AuthorizationEnvironment> { state, action, environment in
    switch action {
    case .alert(.dismiss):
        state.alert = nil
    case .alert(.go(let session)):
        state.alert = nil
    case .showError(let error):
        state.isLoading = false
        printLog(error)
    case .changeLogin(let login):
        state.login = login
    case .changePassword(let password):
        state.password = password
    case .login:
        let login = state.login
        let password = state.password
        return Effect.task(operation: { () -> AuthorizationAction in
            do {
                let response: LoginResponse = try await environment.apiClient.send(
                    AuthorizationRequest.login(email: login, password: password)
                )
                let token = AuthorizationToken(accessToken: response.accessToken,
                                               refreshToken: response.refreshToken)
                return AuthorizationAction.updateCachedToken(token)
            } catch {
                return AuthorizationAction.showError(error.localizedDescription)
            }
        })
        .receive(on: DispatchQueue.main)
        .eraseToEffect()
    case .updateCachedToken(let token):
        environment.tokenManager.authorizationToken = token
        state.token = token

    case .handleSIWALogin(let authorization):
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:

            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email

            return Effect.task(operation: {
                do {
                    let request = AuthorizationRequest.siwa(appleToken: userIdentifier,
                                                            firstName: fullName?.givenName,
                                                            lastName: fullName?.familyName,
                                                            email: email ?? environment.userService.user?.email,
                                                            imageURL: nil)
                    let response: LoginResponse = try await environment.apiClient.send(request)
                    let token = AuthorizationToken(accessToken: response.accessToken,
                                                   refreshToken: response.refreshToken)
                    return AuthorizationAction.updateCachedToken(token)
                } catch {
                    return AuthorizationAction.showError(error.localizedDescription)
                }
            })
        default:
            break
        }
    }

    return .none
}
