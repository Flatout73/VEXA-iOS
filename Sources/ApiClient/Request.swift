//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 12.06.2022.
//

import Foundation
import Alamofire
import SwiftProtobuf

public enum RequestParams {
    case alamofire(Alamofire.Parameters, encoding: ParameterEncoding = JSONEncoding())
    case protobuf(SwiftProtobuf.Message)
}

public protocol Request {
    var method: HTTPMethod { get }
    var path: String { get }
    var paramaters: RequestParams? { get }
    var headers: HTTPHeaders? { get }
}

public extension Request {
    var headers: HTTPHeaders? { nil }
    var paramaters: RequestParams? { nil }
}
