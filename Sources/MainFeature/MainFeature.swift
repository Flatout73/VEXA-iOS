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

public struct MainState: Equatable {
	public var alert: AlertState<MainAction.AlertAction>?
    public var content: [Protobuf.Content] = []

    public var isLoading = false

	public init() {

	}
}

public enum MainAction: Equatable {
	case alert(AlertAction)
    case fetchContent
    case show([Protobuf.Content])
    case showError(String)

	public enum AlertAction: Equatable {
		case dismiss
		case go(String)
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
	mainReducerCore
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
                return MainAction.show(content)
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
    }

	return .none
}
