// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: GeneralResponse.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

public struct GeneralResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var response: GeneralResponse.OneOf_Response? = nil

  public var error: GeneralError {
    get {
      if case .error(let v)? = response {return v}
      return GeneralError()
    }
    set {response = .error(newValue)}
  }

  public var content: SwiftProtobuf.Google_Protobuf_Any {
    get {
      if case .content(let v)? = response {return v}
      return SwiftProtobuf.Google_Protobuf_Any()
    }
    set {response = .content(newValue)}
  }

  public var arrayContent: ArrayResponse {
    get {
      if case .arrayContent(let v)? = response {return v}
      return ArrayResponse()
    }
    set {response = .arrayContent(newValue)}
  }

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public enum OneOf_Response: Equatable {
    case error(GeneralError)
    case content(SwiftProtobuf.Google_Protobuf_Any)
    case arrayContent(ArrayResponse)

  #if !swift(>=4.1)
    public static func ==(lhs: GeneralResponse.OneOf_Response, rhs: GeneralResponse.OneOf_Response) -> Bool {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch (lhs, rhs) {
      case (.error, .error): return {
        guard case .error(let l) = lhs, case .error(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.content, .content): return {
        guard case .content(let l) = lhs, case .content(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.arrayContent, .arrayContent): return {
        guard case .arrayContent(let l) = lhs, case .arrayContent(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      default: return false
      }
    }
  #endif
  }

  public init() {}
}

#if swift(>=5.5) && canImport(_Concurrency)
extension GeneralResponse: @unchecked Sendable {}
extension GeneralResponse.OneOf_Response: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension GeneralResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = "GeneralResponse"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "error"),
    2: .same(proto: "content"),
    3: .same(proto: "arrayContent"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try {
        var v: GeneralError?
        var hadOneofValue = false
        if let current = self.response {
          hadOneofValue = true
          if case .error(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.response = .error(v)
        }
      }()
      case 2: try {
        var v: SwiftProtobuf.Google_Protobuf_Any?
        var hadOneofValue = false
        if let current = self.response {
          hadOneofValue = true
          if case .content(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.response = .content(v)
        }
      }()
      case 3: try {
        var v: ArrayResponse?
        var hadOneofValue = false
        if let current = self.response {
          hadOneofValue = true
          if case .arrayContent(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.response = .arrayContent(v)
        }
      }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    switch self.response {
    case .error?: try {
      guard case .error(let v)? = self.response else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }()
    case .content?: try {
      guard case .content(let v)? = self.response else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }()
    case .arrayContent?: try {
      guard case .arrayContent(let v)? = self.response else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
    }()
    case nil: break
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: GeneralResponse, rhs: GeneralResponse) -> Bool {
    if lhs.response != rhs.response {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
