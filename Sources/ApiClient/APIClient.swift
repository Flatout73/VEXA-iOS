import Combine
import ComposableArchitecture
import Foundation
import SharedModels
import Alamofire

public actor APIClient {
    let session: Session
    let interceptor: AuthenticationInterceptor<VEXAAuthenticator>

    public init(tokenManager: TokenManager,
                configuration: URLSessionConfiguration = .default,
                sessionDelegate: SessionDelegate = SessionDelegate()) {
        let authenticator = VEXAAuthenticator()
        self.interceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                     credential: tokenManager)
        self.session = Session(configuration: configuration,
                               delegate: sessionDelegate,
                               interceptor: interceptor)
    }
}
