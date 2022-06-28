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

public enum MainRoute: Hashable {
    case details(ContentDetailsState)
}

public struct MainState: Equatable {
	public var alert: AlertState<MainAction.AlertAction>?
    public var content: [Discovery] = Mock.discovery

    public var filteredContent: [Discovery]?

    public var isLoading = false

    public var route: MainRoute?

    public var searchText = ""

    public init() {

	}
}

public enum MainAction: Equatable {
	case alert(AlertAction)
    case fetchContent
    case show([Discovery])
    case showError(String)

    case search(String)

    case details(ContentDetailsAction)
    case setNavigation(MainRoute?)

	public enum AlertAction: Equatable {
		case dismiss
		case go(String)
	}
}

extension MainEnvironment {
    var contentDetails: ContentDetailsEnvironment {
        ContentDetailsEnvironment(apiClient: self.apiClient)
    }
}

public struct MainEnvironment {
	let feedbackGenerator: UIImpactFeedbackGenerator
    let apiClient: APIClient

	public init(apiClient: APIClient, feedbackGenerator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)) {
        self.apiClient = apiClient
		self.feedbackGenerator = feedbackGenerator
	}
}

public let mainReducer = Reducer<MainState, MainAction, MainEnvironment>.combine(
	mainReducerCore,
    contentDetailsReducerCore._pullback(
        state: (\MainState.route).appending(path: /MainRoute.details),
        action: /MainAction.details,
        environment: \.contentDetails)
)

let mainReducerCore = Reducer<MainState, MainAction, MainEnvironment> { state, action, environment in
    enum CancelId {}

	switch action {
    case .fetchContent:
        state.isLoading = true
        let request = APIConstants.Content.discovery
        return Effect.task(operation: {
            do {
                let content: [Protobuf.Content] = try await environment.apiClient.send(request)
                return MainAction.show(
                    content.map {
                        return Discovery(id: $0.id,
                                         ambassador: "\($0.ambassador.user.firstName) \($0.ambassador.user.lastName)",
                                         universityName: "University",
                                         videoName: $0.title,
                                         category: "Category",
                                         desctription: $0.debugDescription,
                                         videoURL: URL(string: $0.videoURL),
                                         image: URL(string: $0.imageURL))
                    }
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
        state.content = content
    case .details:
        return .none
    case .setNavigation(let tag):
        state.route = tag
    case .search(let text):
        state.searchText = text
        if !text.isEmpty {
            state.filteredContent = state.content.filter({ $0.ambassador.contains(text) || $0.category.contains(text) ||
                $0.universityName.contains(text) || $0.videoName.contains(text) })
        } else {
            state.filteredContent = nil
        }
    }

	return .none
}
