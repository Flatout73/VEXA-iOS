// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: Chat/webSocketMessage.proto
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

public struct WebSocketMessage {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var id: String = String()

  public var client: String = String()

  public var content: WebSocketMessage.OneOf_Content? = nil

  public var textMessage: ChatMessage {
    get {
      if case .textMessage(let v)? = content {return v}
      return ChatMessage()
    }
    set {content = .textMessage(newValue)}
  }

  public var imageMessage: ImageMessage {
    get {
      if case .imageMessage(let v)? = content {return v}
      return ImageMessage()
    }
    set {content = .imageMessage(newValue)}
  }

  public var connectMessage: ConnectMessage {
    get {
      if case .connectMessage(let v)? = content {return v}
      return ConnectMessage()
    }
    set {content = .connectMessage(newValue)}
  }

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public enum OneOf_Content: Equatable {
    case textMessage(ChatMessage)
    case imageMessage(ImageMessage)
    case connectMessage(ConnectMessage)

  #if !swift(>=4.1)
    public static func ==(lhs: WebSocketMessage.OneOf_Content, rhs: WebSocketMessage.OneOf_Content) -> Bool {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch (lhs, rhs) {
      case (.textMessage, .textMessage): return {
        guard case .textMessage(let l) = lhs, case .textMessage(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.imageMessage, .imageMessage): return {
        guard case .imageMessage(let l) = lhs, case .imageMessage(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.connectMessage, .connectMessage): return {
        guard case .connectMessage(let l) = lhs, case .connectMessage(let r) = rhs else { preconditionFailure() }
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
extension WebSocketMessage: @unchecked Sendable {}
extension WebSocketMessage.OneOf_Content: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension WebSocketMessage: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = "WebSocketMessage"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .same(proto: "client"),
    3: .same(proto: "textMessage"),
    4: .same(proto: "imageMessage"),
    5: .same(proto: "connectMessage"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.id) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.client) }()
      case 3: try {
        var v: ChatMessage?
        var hadOneofValue = false
        if let current = self.content {
          hadOneofValue = true
          if case .textMessage(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.content = .textMessage(v)
        }
      }()
      case 4: try {
        var v: ImageMessage?
        var hadOneofValue = false
        if let current = self.content {
          hadOneofValue = true
          if case .imageMessage(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.content = .imageMessage(v)
        }
      }()
      case 5: try {
        var v: ConnectMessage?
        var hadOneofValue = false
        if let current = self.content {
          hadOneofValue = true
          if case .connectMessage(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.content = .connectMessage(v)
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
    if !self.id.isEmpty {
      try visitor.visitSingularStringField(value: self.id, fieldNumber: 1)
    }
    if !self.client.isEmpty {
      try visitor.visitSingularStringField(value: self.client, fieldNumber: 2)
    }
    switch self.content {
    case .textMessage?: try {
      guard case .textMessage(let v)? = self.content else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
    }()
    case .imageMessage?: try {
      guard case .imageMessage(let v)? = self.content else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 4)
    }()
    case .connectMessage?: try {
      guard case .connectMessage(let v)? = self.content else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
    }()
    case nil: break
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: WebSocketMessage, rhs: WebSocketMessage) -> Bool {
    if lhs.id != rhs.id {return false}
    if lhs.client != rhs.client {return false}
    if lhs.content != rhs.content {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}