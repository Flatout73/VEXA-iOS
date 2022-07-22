//
//  File.swift
//  
//
//  Created by Егор on 20.06.2022.
//

import Foundation


public struct UniversityModel: Identifiable, Equatable, Hashable {
    
    public let id: String
    public var name: String
    public var photos: [URL]
    public var tags: [String]
    public var applyLink: String
    public var studentsCount: Int
    public var gpa: Int
    public var exams: String
    public var requirementsDescription: String
    public var facties: String
    public var latitude: Double
    public var longitude: Double
    public var phone: String
    public var address: String
    
    public var type: String
    public var ambassadors: [String]
    public var facilities: String
    public var programList: String
    public var content: [String]
    public var price: Int
 
    public init(id: String,
                name: String,
                photos: [URL],
                tags: [String],
                applyLink: String,
                studentsCount: Int,
                gpa: Int,
                exams: String,
                requirementsDescription: String,
                facties: String,
                latitude: Double,
                longitude: Double,
                phone: String,
                address: String,
                
                type: String,
                ambassadors: [String],
                facilities: String,
                programList: String,
                content: [String],
                price: Int) {
        
        self.id = id
        self.name = name
        self.photos = photos
        self.tags = tags
        self.applyLink = applyLink
        self.studentsCount = studentsCount
        self.gpa = gpa
        self.exams = exams
        self.requirementsDescription = requirementsDescription
        self.facties = facties
        self.latitude = latitude
        self.longitude = longitude
        self.phone = phone
        self.address = address
        
        self.type = type
        self.ambassadors = ambassadors
        self.facilities = facilities
        self.address = address
        self.phone = phone
        self.programList = programList
        self.content = content
        self.price = price
    }
    
}

extension UniversityModel: Codable {
    
}
