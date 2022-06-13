//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 12.06.2022.
//

import Foundation

public struct AuthorizationToken: Codable {
    public let accessToken: String
    public let refreshToken: String
}
