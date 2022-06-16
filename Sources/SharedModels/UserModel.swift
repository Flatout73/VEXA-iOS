//
//  File.swift
//  
//
//  Created by Егор on 16.06.2022.
//

import Foundation


public struct User: Identifiable, Equatable {
    public let id: String
    public let firstName, secondName, email, dateOfBirth, country, nativeLanguage: String
    public let image: URL?

    public init(id: String, firstName: String, secondName: String, email: String, dateOfBirth: String, country: String, nativeLanguage: String, image: URL? = nil) {
        self.id = id
        self.firstName = firstName
        self.secondName = secondName
        self.email = email
        self.dateOfBirth = dateOfBirth
        self.country = country
        self.nativeLanguage = nativeLanguage
        self.image = image
    }
}
