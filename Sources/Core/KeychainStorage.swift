//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 12.06.2022.
//

import SwiftUI
import KeychainAccess

@propertyWrapper
public struct KeychainStorage<Value: Codable>{
    private let keychain = Keychain()
    private let valueKey: String
    private var value: Value?

    private let jsonDecoder = JSONDecoder()

    public init(wrappedValue defaultValue: Value? = nil, key: String) {
        valueKey = key

        do {
            if let data = try keychain.getData(key) {
                value = try jsonDecoder.decode(Value.self, from: data)
            } else {
                value = defaultValue
            }
        } catch {
            printLog(error.localizedDescription)
        }
    }

    public var wrappedValue: Value? {
        get {
            return value
        }
        set {
            value = newValue

            do {
                if let storeValue = newValue {
                    try keychain.set(JSONEncoder().encode(storeValue), key: valueKey)
                } else {
                    try keychain.remove(valueKey)
                }
            } catch {
                printLog(error.localizedDescription)
            }
        }
    }
}
