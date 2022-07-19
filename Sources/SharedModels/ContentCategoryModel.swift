//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 08.07.2022.
//

import Foundation
import SwiftUI
import Protobuf

public enum ContentCategoryModel: String, Codable, CaseIterable, Identifiable {
    public var id: String { self.rawValue }

    case other
    case housing
    case dining
    case sportsAndRecreation
    case academics
    case healthAndSafety
    case career
    case campusEvents
    case campusClubs

    public var title: LocalizedStringKey {
        LocalizedStringKey(self.rawValue)
    }
}

public extension ContentCategory {
    var model: ContentCategoryModel {
        switch self {
        case .other:
            return .other
        case .housing:
            return .housing
        case .dining:
            return .dining
        case .sportsAndRecreation:
            return .sportsAndRecreation
        case .academics:
            return .academics
        case .healthAndSafety:
            return .healthAndSafety
        case .career:
            return .career
        case .campusEvents:
            return .campusEvents
        case .campusClubs:
            return .campusClubs
        case .UNRECOGNIZED(let int):
            return .other
        }
    }
}
