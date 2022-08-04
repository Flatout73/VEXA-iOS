//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 21.02.2022.
//

import Foundation
import PulseCore
import Pulse
import Logging
import Core

public class VEXALogger {
    public static let shared = VEXALogger()

    public var metadata: Logger.Metadata? = nil

    var storeURL: URL? {
        let group = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: Constants.group)
        return group?.appendingPathComponent("Cache")
    }

    public private(set) lazy var loggerStore: LoggerStore = {
        if let url = storeURL {
            return (try? LoggerStore(storeURL: url, options: [.create])) ?? .default
        } else {
            return LoggerStore.default
        }
    }()

    private lazy var logger = Logger(label: Bundle.main.bundleIdentifier ?? "com.vexa") { label in
        PersistentLogHandler(label: label, store: loggerStore)
    }

    private init() { }

    public func info(_ info: String) {
        logger.info(.init(stringLiteral: info), metadata: metadata)
    }

    public func debug(_ debug: String?) {
        guard let debug = debug else { return }
        printLog(debug)
        logger.debug(.init(stringLiteral: debug), metadata: metadata)
    }

    public func warning(_ warning: String) {
        logger.warning(.init(stringLiteral: warning), metadata: metadata)
    }

    public func error(_ error: Error?) {
        guard let error = error else {
            return
        }
        #if DEBUG
        print(error)
        #endif
        logger.error(.init(stringLiteral: error.localizedDescription), metadata: metadata)
    }
    public func error(_ error: String) {
        #if DEBUG
        print(error)
        #endif
        logger.error(.init(stringLiteral: error), metadata: metadata)
    }
}
