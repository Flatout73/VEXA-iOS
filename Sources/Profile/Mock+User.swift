//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 21.06.2022.
//

import Foundation
import SharedModels

public extension Mock {
    static var userV: User {
        User(id: "0", firstName: "Leonid", secondName: "Leonidovich", email: "Leonid@mail.ru", dateOfBirth: "04.04.1944", country: "Russia", nativeLanguage: "Russian", universities: ["University Name", "University Name2"], content: ["Jane", "aboutIMG"], image: URL(string: "https://i.stack.imgur.com/e54hT.png"))
    }
}
