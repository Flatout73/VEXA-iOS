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
    case sendMessage(String)

    public enum AlertAction: Equatable {
        case dismiss
        case go(String)
    }
}

public struct ChatEnvironment {
    let apiClient: APIClient
    let chatClient: SocketClient

    public init(apiClient: APIClient, socketClient: SocketClient) {
        self.apiClient = apiClient
        self.chatClient = socketClient
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
    case .sendMessage(let text):
        var message = WebSocketMessage()
        message.id = UUID().uuidString
        message.client = Constants.uuid.uuidString
        var content = ChatMessage()
        content.text = text
        message.content = WebSocketMessage.OneOf_Content.textMessage(content)
        try? environment.chatClient.send(message: message)
    }

    return .none
}
