//
//  Main.swift
//  
//
//  Created by Leonid Lyadveykin on 16.02.2022.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import SharedModels
import UIKit
import Services
import AVKit
import ApiClient
import Core
import Protobuf
import ContentDetails
import CasePaths


public struct MainState: Equatable {
	public var alert: AlertState<MainAction.AlertAction>?
    public var content: [DiscoveryModel] = Mock.discovery

    public var isLoading = false

    var selection: Identified<DiscoveryModel.ID, ContentDetailsState?>?

    public var searchText: String?

    public var category: ContentCategoryModel?

    public init() {

	}
}

public enum MainAction: Equatable {
	case alert(AlertAction)
    case fetchContent
    case show([Protobuf.Content])
    case showError(String)

    case search(String?, category: ContentCategoryModel?)

    case details(ContentDetailsAction)
    case setNavigation(selection: String?)

	public enum AlertAction: Equatable {
		case dismiss
		case go(String)
	}
}

extension MainEnvironment {
    var contentDetails: ContentDetailsEnvironment {
        ContentDetailsEnvironment(apiClient: self.apiClient, streamChatService: streamChatService)
    }
}

public struct MainEnvironment {
	let feedbackGenerator: UIImpactFeedbackGenerator
    let apiClient: APIClient
    let streamChatService: StreamChatService

	public init(apiClient: APIClient, streamChatService: StreamChatService, feedbackGenerator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)) {
        self.apiClient = apiClient
        self.streamChatService = streamChatService
		self.feedbackGenerator = feedbackGenerator
	}
}

public let mainReducer = Reducer<MainState, MainAction, MainEnvironment>.combine(
	mainReducerCore,
    contentDetailsReducerCore
        .optional()
        .pullback(state: \Identified.value, action: .self, environment: { $0 })
        .optional()
        .pullback(
        state: \MainState.selection,
        action: /MainAction.details,
        environment: \.contentDetails)
)

let mainReducerCore = Reducer<MainState, MainAction, MainEnvironment> { state, action, environment in
    enum CancelId {}

	switch action {
    case .fetchContent:
        state.isLoading = true
        state.searchText = nil
        state.category = nil
        let request = APIConstants.Content.discovery
        return Effect.task(operation: {
            do {
                let content: [Protobuf.Content] = try await environment.apiClient.send(request)
                return MainAction.show(
                    content
                )
            } catch {
                return MainAction.showError(error.localizedDescription)
            }
        })
        .receive(on: DispatchQueue.main)
        .eraseToEffect()
	case .alert(.dismiss):
		state.alert = nil
	case .alert(.go(let session)):
		state.alert = nil
    case .showError(let error):
        state.isLoading = false
        printLog(error)
    case .show(let content):
        state.isLoading = false
        state.content = content.map {
            let ambassador = DiscoveryModel.Ambassador(id: $0.ambassador.user.id,
                                                       name: "\($0.ambassador.user.firstName) \($0.ambassador.user.lastName)",
                                                       imageURL: URL(string: $0.ambassador.user.imageURL),
                                                       universityName: $0.ambassador.university.name)
            return DiscoveryModel(id: $0.id,
                                  ambassador: ambassador,
                                  universityName: $0.ambassador.university.name,
                                  videoName: $0.title,
                                  category: $0.category.model,
                                  desctription: $0.description_p,
                                  likesCount: Int($0.likesCount),
                                  isLiked: $0.isLikedByMe,
                                  videoURL: URL(string: $0.videoURL),
                                  image: URL(string: $0.imageURL))
        }
    case .details(.openDeeplink(let url)):
        UIApplication.shared.open(url)
    case .details:
        return .none
    case let .setNavigation(selection: .some(id)):
        if let content = state.content.first(where: { $0.id == id }) {
            state.selection = Identified(ContentDetailsState(discovery: content), id: id)
        }
    case let .setNavigation(selection: .none):
//      if let selection = state.selection, let count = selection.value?.count {
//        state.rows[id: selection.id]?.count = count
//      }
      state.selection = nil
      return .cancel(id: CancelId.self)
    case .search(let text, let category):
        state.searchText = text
        state.category = category

        guard text?.isEmpty == false || category != nil else {
            return Effect(value: MainAction.fetchContent)
        }

        let request = APIConstants.Content.search(text, category: category)
        return Effect.task(operation: {
            do {
                let content: [Protobuf.Content] = try await environment.apiClient.send(request)
                return MainAction.show(content)
            } catch {
                return MainAction.show([])
            }
        })
    }

	return .none
}
