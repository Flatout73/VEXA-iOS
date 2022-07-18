//
//  File.swift
//  
//
//  Created by Егор on 20.06.2022.
//

import Foundation
import SharedModels

public extension Mock {
    
    static var university: UniversityModel {
        
        UniversityModel(
            id: "0",
            name: "Harper College",
            photos: [],
            tags: ["#2 year", "#public", "#harper", "#community"],
            applyLink: "",
            studentsCount: 3600,
            gpa: 3,
            exams: "IELTs",
            requirementsDescription: "Extra text text text",
            facties: "adeawd",
            latitude: 44444.22,
            longitude: 3231312,
            phone: "+1 (847) 925-6000",
            address: "1200 West Algonquin Road, Palatine, ID 60067",
            
            
            type: "2-year, Public, Community college",
            ambassadors: ["Jane", "Jane", "Jane"],
            facilities: """
                        Harper Academic Support Center
                        Health and Recreation Center
                        The Arts at Harper
                        Student Clubs and Organization
                        """,
            programList: "https://www.harpercollege.edu/index.php",
            content: ["Harper College", "Harper College", "HarperLifeStyle"],
            link: "https://www.harpercollege.edu/index.php",
            price: "$20,000 per year for undergraduate studies, $30,000 for graduate studies"
        )
    }
}
