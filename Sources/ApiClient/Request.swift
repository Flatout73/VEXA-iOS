//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 12.06.2022.
//

import Foundation
import Alamofire

public protocol Request {
    var method: HTTPMethod { get }
    var path: String { get }
    var paramaters: Alamofire.Parameters? { get }
    var headers: HTTPHeaders? { get }
    var encoding: ParameterEncoding { get }
}

public extension Request {
    var headers: HTTPHeaders? { nil }
    var encoding: ParameterEncoding { JSONEncoding() }
    var paramaters: Alamofire.Parameters? { nil }
}
