//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 21.06.2022.
//

import Foundation
import SharedModels

public extension Mock {
    static var userV: StudentModel {
        StudentModel(id: "0", status: .emailVerified, firstName: "Leonid", secondName: "Leonidovich", email: "Leonid@mail.ru", dateOfBirth: Date(), country: "Russia", nativeLanguage: "Russian", image: URL(string: "https://i.stack.imgur.com/e54hT.png"))
    }
}
