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

    public var discovery: DiscoveryModel
    
    public var isLoading = false

    public init(discovery: DiscoveryModel) {
        self.discovery = discovery
    }
    
}

public enum ContentDetailsAction: Equatable {
    case alert(AlertAction)
    case showError(String)

    case like
    case openChat(ambassadorID: String)
    case openDeeplink(URL)

    public enum AlertAction: Hashable {
        case dismiss
        case go(String)
    }
}

public struct ContentDetailsEnvironment {
    let apiClient: APIClient
    let streamChatService: StreamChatService

    public init(apiClient: APIClient, streamChatService: StreamChatService) {
        self.apiClient = apiClient
        self.streamChatService = streamChatService
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
    case .like:
        // TODO: Send like to server
        //state.discovery.isLiked = !state.discovery.isLiked
        break
    case .openChat(let ambassadorID):
        return Effect.task(operation:  { () -> ContentDetailsAction in
            do {
                guard let cid = try await environment.streamChatService.createChannel(for: ambassadorID) else {
                    return ContentDetailsAction.showError("No cid")
                }
                let deeplink = URL(string: "vexa://chat/messaging:\(cid)")!
                return ContentDetailsAction.openDeeplink(deeplink)
            } catch {
                return ContentDetailsAction.showError(error.localizedDescription)
            }
        })
    case .openDeeplink(_):
        break
    }

    return .none
}
