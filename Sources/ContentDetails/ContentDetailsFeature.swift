import Foundation
import SwiftUI
import ComposableArchitecture
import SharedModels
import Services
import ApiClient
import Core
import Protobuf

public struct ContentDetailsState: Hashable {
    public var alert: AlertState<ContentDetailsAction.AlertAction>?

    public var discovery: Discovery

    public var isLoading = false

    public init(discovery: Discovery) {
        self.discovery = discovery
    }
}

public enum ContentDetailsAction: Equatable {
    case alert(AlertAction)
    case showError(String)

    public enum AlertAction: Hashable {
        case dismiss
        case go(String)
    }
}

public struct ContentDetailsEnvironment {
    let apiClient: APIClient

    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
}

public let contentDetailsReducerCore = Reducer<ContentDetailsState, ContentDetailsAction, ContentDetailsEnvironment> { state, action, environment in
    switch action {
    case .alert(.dismiss):
        state.alert = nil
    case .alert(.go(let session)):
        state.alert = nil
    case .showError(let error):
        state.isLoading = false
        printLog(error)
    }

    return .none
}
