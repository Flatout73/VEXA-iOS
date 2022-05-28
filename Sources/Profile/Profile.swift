//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 16.02.2022.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import SharedModels

public struct ProfileState: Equatable {
	public enum Screen: String, CaseIterable, Identifiable {
		public var id: String { title }

		case heal
		case stage
		case data

		var title: String {
			switch self {
				case .heal:
					return "first_aid_kit"
				case .stage:
					return "stage"
				case .data:
					return "data"
			}
		}
	}
	var screen: Screen = .heal

	public init() {

	}
}

public enum ProfileAction: Equatable {
	case changeTo(screen: ProfileState.Screen)
}

public struct ProfileEnvironment {
	public init() {
		
	}
}


public let profileReducer = Reducer<ProfileState, ProfileAction, ProfileEnvironment> { state, action, environment in
	switch action {
		case .changeTo(let screen):
		state.screen = screen
	}

	return .none
}

