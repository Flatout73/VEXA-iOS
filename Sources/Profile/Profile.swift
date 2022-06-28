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

	public init() {

	}
}

public enum ProfileAction: Equatable {
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
    case .show(let content):
        state.content = content
    case .showError(let error):
        state.isLoading = false
    }

	return .none
}

