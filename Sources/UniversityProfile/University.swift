//
//  File.swift
//  
//
//  Created by Егор on 20.06.2022.
//

import SwiftUI
import ComposableArchitecture
import Analytics
import Log
import CoreUI
import SharedModels
import Resources
import ApiClient
import Core
import Protobuf

public struct UniversityState: Hashable {
    
    public var alert: AlertState<UniversityAction.AlertAction>?
    
    public var content: UniversityModel
    
    public var isLoading = false

    public init(content: UniversityModel) {
        self.content = content
    }
}

public enum UniversityAction: Equatable {
    
    case show(UniversityModel)
    case alert(AlertAction)
    case showError(String)

    public enum AlertAction: Hashable {
        case dismiss
        case go(String)
    }
}

public struct UniversityEnvironment {
    let apiClient: APIClient

    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
}

public let uniReducer = Reducer<UniversityState, UniversityAction, UniversityEnvironment>.combine(
    universityReducer
)

public let universityReducer = Reducer<UniversityState, UniversityAction, UniversityEnvironment> { state, action, environment in
    switch action {
    case .show(let content):
        state.content = content
    case .showError(let error):
        state.isLoading = false
    case .alert(.dismiss):
        state.alert = nil
    case .alert(.go(let session)):
        state.alert = nil
    }

    return .none
}

