import Foundation
import SwiftUI
import ComposableArchitecture
import SharedModels
import Services
import ApiClient
import Core
import Protobuf

public struct ChatState: Equatable {
    public var alert: AlertState<ChatAction.AlertAction>?

    public var isLoading = false

    public init() {

    }
}

public enum ChatAction: Equatable {
    case alert(AlertAction)
    case showError(String)
    case connect

    public enum AlertAction: Equatable {
        case dismiss
        case go(String)
    }
}

public struct ChatEnvironment {
    let apiClient: APIClient
    let chatClient = SocketClient()

    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
}

public let chatReducerCore = Reducer<ChatState, ChatAction, ChatEnvironment> { state, action, environment in
    switch action {
    case .alert(.dismiss):
        state.alert = nil
    case .alert(.go(let session)):
        state.alert = nil
    case .showError(let error):
        state.isLoading = false
        printLog(error)
    case .connect:
        environment.chatClient.openWebSocket()
    }

    return .none
}
