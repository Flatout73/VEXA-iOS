import ApiClient
import ComposableArchitecture
import SharedModels
import UIApplicationClient
import UIKit
import Services

public struct AppEnvironment {
    public var apiClient: APIClient
    public let tokenManager: TokenManager
    public let socketClient: SocketClient
    public let streamChatService: StreamChatService
    public let userService: UserService
    public var applicationClient: UIApplicationClient
    public var backgroundQueue: AnySchedulerOf<DispatchQueue>
    public var mainQueue: AnySchedulerOf<DispatchQueue>
    public var mainRunLoop: AnySchedulerOf<RunLoop>
    public var setUserInterfaceStyle: (UIUserInterfaceStyle) -> Effect<Never, Never>
    public var timeZone: () -> TimeZone
    
    public init(
        apiClient: APIClient,
        tokenManager: TokenManager,
        socketClient: SocketClient,
        streamChatService: StreamChatService,
        userService: UserService,
        applicationClient: UIApplicationClient,
        backgroundQueue: AnySchedulerOf<DispatchQueue>,
        mainQueue: AnySchedulerOf<DispatchQueue>,
        mainRunLoop: AnySchedulerOf<RunLoop>,
        setUserInterfaceStyle: @escaping (UIUserInterfaceStyle) -> Effect<Never, Never>,
        timeZone: @escaping () -> TimeZone
    ) {
        self.apiClient = apiClient
        self.tokenManager = tokenManager
        self.socketClient = socketClient
        self.streamChatService = streamChatService
        self.userService = userService
        self.applicationClient = applicationClient
        self.backgroundQueue = backgroundQueue
        self.mainQueue = mainQueue
        self.mainRunLoop = mainRunLoop
        self.setUserInterfaceStyle = setUserInterfaceStyle
        self.timeZone = timeZone
    }
}
