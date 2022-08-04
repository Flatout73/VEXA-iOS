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
    public let streamToken: String

    public init(accessToken: String, refreshToken: String, streamToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.streamToken = streamToken
    }
}
