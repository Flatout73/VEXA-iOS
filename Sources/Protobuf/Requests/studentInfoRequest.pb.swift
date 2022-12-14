// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: Requests/studentInfoRequest.proto
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

public struct StudentInfoRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var currentCountry: String {
    get {return _currentCountry ?? String()}
    set {_currentCountry = newValue}
  }
  /// Returns true if `currentCountry` has been explicitly set.
  public var hasCurrentCountry: Bool {return self._currentCountry != nil}
  /// Clears the value of `currentCountry`. Subsequent reads from it will return its default value.
  public mutating func clearCurrentCountry() {self._currentCountry = nil}

  public var nativeLanguage: String {
    get {return _nativeLanguage ?? String()}
    set {_nativeLanguage = newValue}
  }
  /// Returns true if `nativeLanguage` has been explicitly set.
  public var hasNativeLanguage: Bool {return self._nativeLanguage != nil}
  /// Clears the value of `nativeLanguage`. Subsequent reads from it will return its default value.
  public mutating func clearNativeLanguage() {self._nativeLanguage = nil}

  public var otherLanguages: [String] = []

  public var enrollmentYear: Int32 {
    get {return _enrollmentYear ?? 0}
    set {_enrollmentYear = newValue}
  }
  /// Returns true if `enrollmentYear` has been explicitly set.
  public var hasEnrollmentYear: Bool {return self._enrollmentYear != nil}
  /// Clears the value of `enrollmentYear`. Subsequent reads from it will return its default value.
  public mutating func clearEnrollmentYear() {self._enrollmentYear = nil}

  public var bio: String {
    get {return _bio ?? String()}
    set {_bio = newValue}
  }
  /// Returns true if `bio` has been explicitly set.
  public var hasBio: Bool {return self._bio != nil}
  /// Clears the value of `bio`. Subsequent reads from it will return its default value.
  public mutating func clearBio() {self._bio = nil}

  public var dateOfBirth: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _dateOfBirth ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_dateOfBirth = newValue}
  }
  /// Returns true if `dateOfBirth` has been explicitly set.
  public var hasDateOfBirth: Bool {return self._dateOfBirth != nil}
  /// Clears the value of `dateOfBirth`. Subsequent reads from it will return its default value.
  public mutating func clearDateOfBirth() {self._dateOfBirth = nil}

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _currentCountry: String? = nil
  fileprivate var _nativeLanguage: String? = nil
  fileprivate var _enrollmentYear: Int32? = nil
  fileprivate var _bio: String? = nil
  fileprivate var _dateOfBirth: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
}

#if swift(>=5.5) && canImport(_Concurrency)
extension StudentInfoRequest: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension StudentInfoRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = "StudentInfoRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "currentCountry"),
    2: .same(proto: "nativeLanguage"),
    3: .same(proto: "otherLanguages"),
    4: .same(proto: "enrollmentYear"),
    5: .same(proto: "bio"),
    6: .same(proto: "dateOfBirth"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self._currentCountry) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self._nativeLanguage) }()
      case 3: try { try decoder.decodeRepeatedStringField(value: &self.otherLanguages) }()
      case 4: try { try decoder.decodeSingularInt32Field(value: &self._enrollmentYear) }()
      case 5: try { try decoder.decodeSingularStringField(value: &self._bio) }()
      case 6: try { try decoder.decodeSingularMessageField(value: &self._dateOfBirth) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._currentCountry {
      try visitor.visitSingularStringField(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._nativeLanguage {
      try visitor.visitSingularStringField(value: v, fieldNumber: 2)
    } }()
    if !self.otherLanguages.isEmpty {
      try visitor.visitRepeatedStringField(value: self.otherLanguages, fieldNumber: 3)
    }
    try { if let v = self._enrollmentYear {
      try visitor.visitSingularInt32Field(value: v, fieldNumber: 4)
    } }()
    try { if let v = self._bio {
      try visitor.visitSingularStringField(value: v, fieldNumber: 5)
    } }()
    try { if let v = self._dateOfBirth {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 6)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: StudentInfoRequest, rhs: StudentInfoRequest) -> Bool {
    if lhs._currentCountry != rhs._currentCountry {return false}
    if lhs._nativeLanguage != rhs._nativeLanguage {return false}
    if lhs.otherLanguages != rhs.otherLanguages {return false}
    if lhs._enrollmentYear != rhs._enrollmentYear {return false}
    if lhs._bio != rhs._bio {return false}
    if lhs._dateOfBirth != rhs._dateOfBirth {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
