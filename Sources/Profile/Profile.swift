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
import Services

public struct ProfileState: Equatable {
    
    public var user: StudentModel?
    
    public var isLoading = false

    public init(user: StudentModel?) {
        self.user = user
	}
}

public enum ProfileAction: Equatable {
    case show(StudentModel?)
    case showError(String)

    case showLoginScreen

    case onAppear

    public enum AlertAction: Equatable {
        case dismiss
        case go(String)
    }
}

public struct ProfileEnvironment {
    let userService: UserService

	public init(userService: UserService) {
        self.userService = userService
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
    case .onAppear:
        return .task(operation: {
            do {
                let user = try await environment.userService.fetchUser()
                return ProfileAction.show(user)
            } catch {
                return ProfileAction.showError(error.localizedDescription)
            }
        })
        .receive(on: DispatchQueue.main)
        .eraseToEffect()
    }

	return .none
}

