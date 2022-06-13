//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 12.06.2022.
//

import Foundation

@inlinable
public func printLog(_ args: Any...) {
    #if DEBUG
    print(args)
    #endif
}
