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

public struct MainState: Equatable {
	public var alert: AlertState<MainAction.AlertAction>?

	public init() {

	}
}

public enum MainAction: Equatable {
	case alert(AlertAction)

	public enum AlertAction: Equatable {
		case dismiss
		case go(String)
	}
}

public struct MainEnvironment {
	let feedbackGenerator: UIImpactFeedbackGenerator

	public init(feedbackGenerator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)) {
		self.feedbackGenerator = feedbackGenerator
	}
}

public let mainReducer = Reducer<MainState, MainAction, MainEnvironment>.combine(
	mainReducerCore
)

let mainReducerCore = Reducer<MainState, MainAction, MainEnvironment> { state, action, environment in
	switch action {
	case .alert(.dismiss):
		state.alert = nil
	case .alert(.go(let session)):
		state.alert = nil
	}

	return .none
}
