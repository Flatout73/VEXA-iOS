import ApiClient
import Build
import ComposableArchitecture
import SharedModels
import UIApplicationClient
import UIKit

public struct AppEnvironment {
  public var apiClient: APIClient
  public var applicationClient: UIApplicationClient
  public var backgroundQueue: AnySchedulerOf<DispatchQueue>
  public var build: Build
  public var mainQueue: AnySchedulerOf<DispatchQueue>
  public var mainRunLoop: AnySchedulerOf<RunLoop>
  public var setUserInterfaceStyle: (UIUserInterfaceStyle) -> Effect<Never, Never>
  public var timeZone: () -> TimeZone

  public init(
    apiClient: APIClient,
    applicationClient: UIApplicationClient,
    backgroundQueue: AnySchedulerOf<DispatchQueue>,
    build: Build,
    mainQueue: AnySchedulerOf<DispatchQueue>,
    mainRunLoop: AnySchedulerOf<RunLoop>,
    setUserInterfaceStyle: @escaping (UIUserInterfaceStyle) -> Effect<Never, Never>,
    timeZone: @escaping () -> TimeZone
  ) {
    self.apiClient = apiClient
    self.applicationClient = applicationClient
    self.backgroundQueue = backgroundQueue
    self.build = build
    self.mainQueue = mainQueue
    self.mainRunLoop = mainRunLoop
    self.setUserInterfaceStyle = setUserInterfaceStyle
    self.timeZone = timeZone
  }
}
