//
//  File.swift
//  
//
//  Created by Егор on 16.06.2022.
//

import Foundation
import SharedModels

public extension Mock {
    
    static var user: StudentModel {
        
        StudentModel(id: "0", firstName: "Leonid", secondName: "Leonidovich", email: "Leonid@mail.ru", dateOfBirth: Date(), country: "Russia", nativeLanguage: "Russian", image: URL(string: "https://i.stack.imgur.com/e54hT.png"))
    }
}

