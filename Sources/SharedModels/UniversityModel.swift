//
//  File.swift
//  
//
//  Created by Егор on 20.06.2022.
//

import Foundation


public struct UniversityModel: Identifiable, Equatable {
    
    public let id: String
    public var name: String
    public var universityLogos: [URL]
    public var tags: [String]
    public var type: String
    public var location: String
    public var size: String
    public var ambassadors: [String]
    public var admissionRequirements: [String]
    public var facilities: String
    public var contactInformation: String
    public var phone: String
    public var programList: String
    public var content: [String]
    public var link: String
    public var price: String
 
    public init(id: String, universityName: String, universityLogos: [URL], hashtags: [String], type: String, location: String, size: String, ambassadors: [String], admissionRequirements: [String], facilities: String, contactInformation: String, phone: String, programList: String, content: [String], link: String, price: String) {
        
        self.id = id
        self.name = universityName
        self.universityLogos = universityLogos
        self.tags = hashtags
        self.type = type
        self.location = location
        self.size = size
        self.ambassadors = ambassadors
        self.admissionRequirements = admissionRequirements
        self.facilities = facilities
        self.contactInformation = contactInformation
        self.phone = phone
        self.programList = programList
        self.content = content
        self.link = link
        self.price = price
    }
    
}

extension UniversityModel: Codable {
    
}
