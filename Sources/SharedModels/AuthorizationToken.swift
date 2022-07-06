//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 12.06.2022.
//

import Foundation

public struct AuthorizationToken: Codable, Equatable {
    public let accessToken: String
    public let refreshToken: String

    public init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
