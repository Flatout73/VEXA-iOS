import ApiClient
import ComposableArchitecture
import SharedModels
import UIKit
import UserNotifications

public enum AppDelegateAction: Equatable {
  case didFinishLaunching
  case didRegisterForRemoteNotifications(Result<Data, NSError>)
}

struct AppDelegateEnvironment {
  var apiClient: APIClient
  var backgroundQueue: AnySchedulerOf<DispatchQueue>
  var mainQueue: AnySchedulerOf<DispatchQueue>
  var setUserInterfaceStyle: (UIUserInterfaceStyle) -> Effect<Never, Never>
}

let appDelegateReducer = Reducer<
	AppState, AppDelegateAction, AppDelegateEnvironment
> { state, action, environment in
	switch action {
	default:
		return .none
	}
}
