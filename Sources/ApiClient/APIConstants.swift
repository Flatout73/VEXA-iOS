//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 12.06.2022.
//

import Foundation

public enum APIConstants {
    static let baseURL = URL(string: "127.0.0.1/api")

    enum Auth {
        static let refresh = "/auth/refresh"
        static let login = "/auth/login"
    }
}
