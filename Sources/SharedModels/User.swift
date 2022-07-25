//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 25.07.2022.
//

import Foundation

public protocol UserProtocol {
    var id: String { get }
    var firstName: String { get }
    var secondName: String { get }
    var imageURL: URL? { get }
}
