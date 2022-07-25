//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 07.07.2022.
//

import Foundation

public struct AmbassadorModel: UserProtocol {
    public let id: String
    public let firstName: String
    public let secondName: String
    public let imageURL: URL?

    public let universities: [UniversityModel]
}
