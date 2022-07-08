//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 08.07.2022.
//

import Foundation
import SwiftUI

public enum ContentCategory: String, Codable, CaseIterable, Identifiable {
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
