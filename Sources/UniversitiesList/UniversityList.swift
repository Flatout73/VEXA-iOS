//
//  File.swift
//  
//
//  Created by Егор on 23.06.2022.
//

import SwiftUI
import ComposableArchitecture
import Analytics
import Log
import CoreUI
import SharedModels
import Resources

public struct UniversityListState: Equatable {
    
    public var content: [University] = Mock.universities
    
    public var filteredContent: [University]?
    
    public var searchText = ""
    
    public var isLoading = false

    public init() {

    }
}

public enum UniversityListAction: Equatable {
    
    case show([University])
    case showError(String)
    case search(String)

    public enum AlertAction: Equatable {
        case dismiss
        case go(String)
    }
}

public struct UniversityListEnvironment {
    public init() {
        
    }
}

public let uniListReducer = Reducer<UniversityListState, UniversityListAction, UniversityListEnvironment>.combine(
    universityListReducer
)

public let universityListReducer = Reducer<UniversityListState, UniversityListAction, UniversityListEnvironment> { state, action, environment in
    switch action {
    case .show(let content):
        state.content = content
    case .showError(let error):
        state.isLoading = false
    case .search(let text):
        state.searchText = text
        if !text.isEmpty {
            state.filteredContent = state.content.filter({ $0.universityName.contains(text) })
        } else {
            state.filteredContent = nil
        }
    }

    return .none
}
