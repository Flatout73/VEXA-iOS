import Foundation
import SwiftUI
import ComposableArchitecture
import SharedModels
import Services
import ApiClient
import Core
import Protobuf
import StreamChatSwiftUI
import Log

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
    let tokenManager: TokenManager
    let streamChatService: StreamChatService

    public init(apiClient: APIClient, userService: UserService, tokenManager: TokenManager, streamChatService: StreamChatService) {
        self.apiClient = apiClient
        self.userService = userService
        self.tokenManager = tokenManager
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
            if let streamToken = environment.tokenManager.authorizationToken?.streamToken {
                environment.streamChatService.connectUser(user, streamToken: streamToken)
            } else {
                VEXALogger.shared.debug("No stream token")
            }
        } else {
            return Effect(value: StreamChatAction.showError("No user"))
        }
    case .showChannel(let id):
        let info = environment.streamChatService.channelInfo(by: id)
        //state.chatViewModel.selectedChannel = info
        state.chatViewModel.deeplinkChannel = info
    case .clearChannel:
        state.chatViewModel.deeplinkChannel = nil
    }

    return .none
}

extension ChatChannelListViewModel: Equatable {
    public static func == (lhs: ChatChannelListViewModel, rhs: ChatChannelListViewModel) -> Bool {
        return lhs.deeplinkChannel == rhs.deeplinkChannel && lhs.selectedChannel == rhs.selectedChannel
    }
}
