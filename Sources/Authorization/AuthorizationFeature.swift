import Foundation
import SwiftUI
import ComposableArchitecture
import SharedModels
import Services
import ApiClient
import Core
import Protobuf

public struct AuthorizationState: Equatable {
    public var alert: AlertState<AuthorizationAction.AlertAction>?

    var login = "test@test.ru"
    var password = "123456"

    public var isLoading = false

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

    public enum AlertAction: Equatable {
        case dismiss
        case go(String)
    }
}

public struct AuthorizationEnvironment {
    let apiClient: APIClient
    let tokenManager: TokenManager

    public init(apiClient: APIClient, tokenManager: TokenManager) {
        self.apiClient = apiClient
        self.tokenManager = tokenManager
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
    }

    return .none
}
