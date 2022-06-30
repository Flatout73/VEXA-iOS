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
    
    public var user: User?
    
    public var isLoading = false

    public init(user: User? = Mock.user) {
        self.user = user
	}
}

public enum ProfileAction: Equatable {
    case show(User)
    case showError(String)

    case showLoginScreen

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
    case .show(let user):
        state.user = user
    case .showError(let error):
        state.isLoading = false
    case .showLoginScreen:
        break
    }

	return .none
}

