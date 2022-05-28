//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 21.02.2022.
//

import Foundation
import os

public class Log {
	public static let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "VEXA", category: "main")
}
