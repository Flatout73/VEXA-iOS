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
    
    public var content: User = Mock.user
    
    public var isLoading = false
    
	public enum Screen: String, CaseIterable, Identifiable {
		public var id: String { title }
        
		case heal
		case stage
		case data

		var title: String {
			switch self {
				case .heal:
					return "Profile"
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
    
    case show(User)
    case showError(String)

    public enum AlertAction: Equatable {
        case dismiss
        case go(String)
    }
}

public struct ProfileEnvironment {
	public init() {
		
	}
}

public let mainReducer = Reducer<ProfileState, ProfileAction, ProfileEnvironment>.combine(
    profileReducer
)

public let profileReducer = Reducer<ProfileState, ProfileAction, ProfileEnvironment> { state, action, environment in
	switch action {
		case .changeTo(let screen):
		state.screen = screen
    case .show(let content):
        state.content = content
    case .showError(let error):
        state.isLoading = false
    }

	return .none
}

