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

public struct UniversityState: Equatable {
    
    public var content: UniversityModel = Mock.university
    
    public var isLoading = false

    public init() {

    }
}

public enum UniversityAction: Equatable {
    
    case show(UniversityModel)
    case showError(String)

    public enum AlertAction: Equatable {
        case dismiss
        case go(String)
    }
}

public struct UniversityEnvironment {
    public init() {
        
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
    }

    return .none
}

