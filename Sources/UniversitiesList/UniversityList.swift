//
//  File.swift
//  
//
//  Created by Егор on 23.06.2022.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import SharedModels
import UIKit
import Services
import AVKit
import ApiClient
import Core
import Protobuf
import CasePaths
import UniversityProfile

public enum UniversityListRoute: Hashable {
    case details(UniversityState)
}

public struct UniversityListState: Equatable {
    
    public var content: [UniversityModel] = Mock.universities
    
    public var filteredContent: [UniversityModel]?
    
    public var searchText = ""
    
    public var isLoading = false
    
    public var route: UniversityListRoute?

    public init() {

    }
}

public enum UniversityListAction: Equatable {
    
    case fetchContent
    case show([Protobuf.University])
    case showError(String)
    case search(String)
    
    case details(UniversityAction)
    case setNavigation(UniversityListRoute?)

    public enum AlertAction: Equatable {
        case dismiss
        case go(String)
    }
}

public struct UniversityListEnvironment {
    
    let feedbackGenerator: UIImpactFeedbackGenerator
    let apiClient: APIClient
    
    public init(apiClient: APIClient, feedbackGenerator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)) {
        self.apiClient = apiClient
        self.feedbackGenerator = feedbackGenerator
    }
}

public let universityListReducer = Reducer<UniversityListState, UniversityListAction, UniversityListEnvironment> { state, action, environment in
    switch action {
    case .fetchContent:
        state.isLoading = true
        let request = APIConstants.Universities.fetchUniversities
        return Effect.task(operation: {
            do {
                let content: [Protobuf.University] = try await environment.apiClient.send(request)
                return UniversityListAction.show(
                     content
                     )
            } catch {
                return UniversityListAction.showError(error.localizedDescription)
            }
        })

        
    case .show(let content):
        state.isLoading = false
        state.content = content.map {
            return UniversityModel(
                id: $0.id,
                name: $0.name,
                photos: $0.photos.compactMap({ photo in
                    return URL(string: photo)
                }),
                tags: $0.tags,
                applyLink: $0.applyLink,
                studentsCount: Int($0.studentsCount),
                gpa: Int($0.gpa),
                exams: $0.exams,
                requirementsDescription: $0.requirementsDescription,
                facties: $0.facts,
                latitude: $0.latitude,
                longitude: $0.longitude,
                phone: $0.phone,
                address: $0.address,
                type: "no",
                ambassadors: ["no"],
                facilities: "no",
                programList: "no",
                content: ["no"],
                price: 0
            )
        }
    case .showError(let error):
        state.isLoading = false
    case .search(let text):
        state.searchText = text
        if !text.isEmpty {
            state.filteredContent = state.content.filter({ $0.name.contains(text) })
        } else {
            state.filteredContent = nil
        }
        
        let request = APIConstants.Universities.search(text)
        return Effect.task(operation: {
            do {
                let content: [Protobuf.University] = try await environment.apiClient.send(request)
                return UniversityListAction.show(content)
            } catch {
                return UniversityListAction.show([])
            }
        })
        
    case .setNavigation(let tag):
        state.route = tag
    case .details(_):
        return .none
    }

    return .none
}
