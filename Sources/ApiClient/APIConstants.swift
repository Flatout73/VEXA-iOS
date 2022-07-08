//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 12.06.2022.
//

import Foundation

public enum APIConstants {
    #if DEBUG
    static let baseURL = URL(string: "http://127.0.0.1:8080/api")!
    #else
    static let baseURL = URL(string: "https://vexa-app.herokuapp.com/api")!
    #endif

    enum Auth {
        static let refresh = "/auth/refresh"
        static let login = "/auth/login"
    }
}
