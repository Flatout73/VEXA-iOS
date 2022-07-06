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
            universityName: "Harper College",
            universityLogos: [],
            hashtags: ["#2 year", "#public", "#harper", "#community"],
            type: "2-year, Public, Community college",
            location: "Palatine, IL, USA",
            size: "9,767 undergraduate students",
            ambassadors: ["Jane", "Jane", "Jane"],
            admissionRequirements: ["3.0", "IELTS or TOEFL", "Extra text text text"],
            facilities: """
                        Harper Academic Support Center
                        Health and Recreation Center
                        The Arts at Harper
                        Student Clubs and Organization
                        """,
            contactInformation: "1200 West Algonquin Road, Palatine, ID 60067",
            phone: "+1 (847) 925-6000",
            programList: "https://www.harpercollege.edu/index.php",
            content: ["Harper College", "Harper College", "HarperLifeStyle"],
            link: "https://www.harpercollege.edu/index.php",
            price: "$20,000 per year for undergraduate studies, $30,000 for graduate studies"
        )
    }
}
