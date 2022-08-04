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
import EditProfileInfo

public struct ProfileState: Equatable {
    
    public var user: StudentModel?
    
    public var isLoading = false

    public var editProfileInfoState: EditProfileInfoState?  {
        if let user = user {
            return EditProfileInfoState(user: user)
        }

        return nil
    }

    public init(user: StudentModel?) {
        self.user = user
	}
}

public enum ProfileAction: Equatable {
    case show(StudentModel?)
    case showError(String)

    case showLoginScreen
    case logout

    case onAppear

    case editProfile(EditProfileInfoAction)

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
    case .logout:
        environment.userService.user = nil
        state.user = nil
    case .editProfile:
        break
    }

	return .none
}

