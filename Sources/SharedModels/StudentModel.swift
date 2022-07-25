//
//  File.swift
//  
//
//  Created by Егор on 16.06.2022.
//

import Foundation
import SwiftUI


public struct StudentModel: Identifiable, Equatable, UserProtocol {
    public enum Status: String, Codable {
        case emailVerified
        case emailNotVerified

        public var title: LocalizedStringKey? {
            switch self {
            case .emailVerified:
                return nil
            case .emailNotVerified:
                return LocalizedStringKey("email_not_verified")
            }
        }
    }
    public let id: String
    public let status: Status
    public let firstName, secondName, email, country, nativeLanguage: String
    public let dateOfBirth: Date
    public let imageURL: URL?
    public let likes: [DiscoveryModel]

    public init(id: String, status: Status, firstName: String, secondName: String, email: String, dateOfBirth: Date,
                country: String, nativeLanguage: String, image: URL? = nil, likes: [DiscoveryModel] = []) {
        self.id = id
        self.status = status
        self.firstName = firstName
        self.secondName = secondName
        self.email = email
        self.dateOfBirth = dateOfBirth
        self.country = country
        self.nativeLanguage = nativeLanguage
        self.imageURL = image
        self.likes = likes
    }
}

extension StudentModel: Codable {
    
}
