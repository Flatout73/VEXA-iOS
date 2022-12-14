//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 12.06.2022.
//

import Protobuf
import Alamofire
import Log
import SwiftProtobuf
import ComposableArchitecture
import SharedModels

extension APIClient {

    public func send<R: Request, T: SwiftProtobuf.Message>(_ request: R) async throws -> T {
        let response = try await send(request, session: session).serializingString().response
        if let request = response.request {
            VEXALogger.shared.loggerStore.storeRequest(request,
                                                       response: response.response,
                                                       error: response.error?.underlyingError,
                                                       data: response.data,
                                                       metrics: response.metrics,
                                                       session: session.session)
        }
        switch response.result {
        case .success(let val):
            if let errorResponse = try? ErrorResponse(jsonString: val) {
                throw ServerError.server(errorResponse.reason)
            } else {
                return try T(jsonString: val, options: options)
            }
        case .failure(let error):
            if let data = response.data, let errorResponse = try? ErrorResponse(jsonUTF8Data: data) {
                throw ServerError.server(errorResponse.reason)
            } else {
                throw error.underlyingError ?? error
            }
        }
    }

    public func send<R: Request, T: SwiftProtobuf.Message>(_ request: R) async throws -> [T] {
        let response = try await send(request, session: session).serializingString().response
        if let request = response.request {
            VEXALogger.shared.loggerStore.storeRequest(request,
                                                       response: response.response,
                                                       error: response.error?.underlyingError,
                                                       data: response.data,
                                                       metrics: response.metrics,
                                                       session: session.session)
        }

        switch response.result {
        case .success(let val):
            if let errorResponse = try? ErrorResponse(jsonString: val) {
                throw ServerError.server(errorResponse.reason)
            } else {
                let generalResponse = try ArrayResponse(jsonString: val)
                return generalResponse.content.compactMap({ try? T(unpackingAny: $0) })
            }
        case .failure(let error):
            if let errorResponse = try? ErrorResponse(jsonUTF8Data: response.data!) {
                throw ServerError.server(errorResponse.reason)
            } else {
                throw error.underlyingError ?? error
            }
        }
    }

//    public static let decoder: JSONDecoder = {
//        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .secondsSince1970
//        return decoder
//    }()

//    /// ?????????????????? ???????????? ?? ???????????????????????? ??????????
//    public func send<R: Request, T: Decodable>(_ request: R, decoder: JSONDecoder = APIClient.decoder) async throws -> T {
//        let response = await send(request, session: session).serializingDecodable(T.self, decoder: decoder).response
//
//        if let request = response.request {
//            WylsaLogger.shared.loggerStore.storeRequest(request,
//                                                        response: response.response,
//                                                        error: response.error?.underlyingError,
//                                                        data: response.data,
//                                                        metrics: response.metrics,
//                                                        session: session.session)
//        }
//        if let val = response.value {
//            return val
//        } else {
//            throw response.error?.underlyingError ?? APIError.parsing
//        }
//    }
//
//    /// ?????????????????? ???????????? ?????? ?????????????????????????? ????????????????
//    public func send<R: Request>(_ request: R) async throws {
//        let response = await send(request, session: session).serializingData().response
//
//        if let request = response.request {
//            WylsaLogger.shared.loggerStore.storeRequest(request,
//                                                        response: response.response,
//                                                        error: response.error?.underlyingError,
//                                                        data: response.data,
//                                                        metrics: response.metrics,
//                                                        session: session.session)
//        }
//        if let error = response.error?.underlyingError {
//            throw error
//        }
//    }
//
//    public func sendWithoutAuth<R: Request>(_ request: R) async throws {
//        let response = await send(request, session: AF).serializingData().response
//
//        if let request = response.request {
//            WylsaLogger.shared.loggerStore.storeRequest(request,
//                                                        response: response.response,
//                                                        error: response.error?.underlyingError,
//                                                        data: response.data,
//                                                        metrics: response.metrics,
//                                                        session: session.session)
//        }
//        if let error = response.error?.underlyingError {
//            throw error
//        }
//    }
//
//    public func sendWithoutAuthorization<T: Decodable>(request: URLRequest,
//                                                       decoder: JSONDecoder = APIClient.decoder) async throws -> T {
//        let dataRequest = AF.request(request).validate()
//
//        let response = await dataRequest.serializingDecodable(T.self, decoder: decoder).response
//
//        if let request = response.request {
//            WylsaLogger.shared.loggerStore.storeRequest(request,
//                                                        response: response.response,
//                                                        error: response.error?.underlyingError,
//                                                        data: response.data,
//                                                        metrics: response.metrics,
//                                                        session: session.session)
//        }
//        if let val = response.value {
//            return val
//        } else {
//            throw response.error?.underlyingError ?? APIError.parsing
//        }
//    }
//
//    @available(*, deprecated, message: "Use async/await instead")
//    public func sendO(request: URLRequest) async -> DataRequest {
//        return session.request(request).validate()
//    }

    private func send<R: Request>(_ request: R, session: Session) throws -> DataRequest {
        var headers = request.headers ?? [:]
        headers.add(.accept("application/json"))
        headers.add(.contentType("application/json"))

        let url = APIConstants.baseURL.appendingPathComponent(request.path)
        let request: DataRequest = try {
            switch request.paramaters {
            case .alamofire(let params, let encoding):
                return session.request(url,
                                       method: request.method,
                                       parameters: params,
                                       encoding: encoding,
                                       headers: headers)
            case .protobuf(let message):
                var request = try URLRequest(url: url, method: request.method)
                request.httpBody = try message.jsonUTF8Data()
                request.headers = headers
                return session.request(request)
            case .none:
                return session.request(url,
                                       method: request.method,
                                       parameters: nil,
                                       encoding: JSONEncoding(),
                                       headers: headers)
            }
        }()

        return request.validate()
    }
}
