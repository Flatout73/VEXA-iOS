import Foundation
import SwiftUI
import ComposableArchitecture
import SharedModels
import Services
import ApiClient
import Core
import Protobuf
import StreamChatSwiftUI

public struct StreamChatState: Equatable {
    public var alert: AlertState<StreamChatAction.AlertAction>?

    public var isLoading = false

    public var hasUser = false

    public let chatViewModel = ChatChannelListViewModel(channelListController: nil,
                                                        selectedChannelId: nil)

    public init() {

    }
}

public enum StreamChatAction: Equatable {
    case alert(AlertAction)
    case showError(String)

    case onAppear
    case showChannel(id: String)
    case clearChannel

    public enum AlertAction: Equatable {
        case dismiss
        case go(String)
    }
}

public struct StreamChatEnvironment {
    let apiClient: APIClient
    let userService: UserService
    let streamChatService: StreamChatService

    public init(apiClient: APIClient, userService: UserService, streamChatService: StreamChatService) {
        self.apiClient = apiClient
        self.userService = userService
        self.streamChatService = streamChatService
    }
}

public let streamChatReducerCore = Reducer<StreamChatState, StreamChatAction, StreamChatEnvironment> { state, action, environment in
    switch action {
    case .alert(.dismiss):
        state.alert = nil
    case .alert(.go(let session)):
        state.alert = nil
    case .showError(let error):
        state.isLoading = false
        printLog(error)
    case .onAppear:
       // guard !state.hasUser else { break }
        
        if let user = environment.userService.user {
            state.hasUser = true
            environment.streamChatService.connectUser(user)
        } else {
            return Effect(value: StreamChatAction.showError("No user"))
        }
    case .showChannel(let id):
        state.chatViewModel.deeplinkChannel = environment.streamChatService.channelInfo(by: id)
    case .clearChannel:
        state.chatViewModel.deeplinkChannel = nil
    }

    return .none
}

extension ChatChannelListViewModel: Equatable {
    public static func == (lhs: ChatChannelListViewModel, rhs: ChatChannelListViewModel) -> Bool {
        return lhs.deeplinkChannel == rhs.deeplinkChannel
    }
}
