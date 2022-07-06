//
//  File.swift
//  
//
//  Created by Егор on 16.06.2022.
//

import Foundation


public struct StudentModel: Identifiable, Equatable {
    public let id: String
    public let firstName, secondName, email, country, nativeLanguage: String
    public let dateOfBirth: Date
    public let imageURL: URL?

    public init(id: String, firstName: String, secondName: String, email: String, dateOfBirth: Date,
                country: String, nativeLanguage: String, image: URL? = nil) {
        self.id = id
        self.firstName = firstName
        self.secondName = secondName
        self.email = email
        self.dateOfBirth = dateOfBirth
        self.country = country
        self.nativeLanguage = nativeLanguage
        self.imageURL = image
    }
}

extension StudentModel: Codable {
    
}
