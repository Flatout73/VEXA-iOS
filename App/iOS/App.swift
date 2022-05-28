//
//  VEXA_iOSApp.swift
//  Shared
//
//  Created by Leonid Lyadveykin on 14.02.2022.
//

import AppFeature
import ApiClient
import Build
import SwiftUI
import UIApplicationClient
import ComposableArchitecture
import Resources

final class AppDelegate: NSObject, UIApplicationDelegate {
  let store = Store(
	initialState: .init(),
	reducer: appReducer,
	environment: .live
  )
  lazy var viewStore = ViewStore(
	self.store.scope(state: { _ in () }),
	removeDuplicates: ==
  )
    
	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
	) -> Bool {
		self.viewStore.send(.appDelegate(.didFinishLaunching))
		return true
	}

  func application(
	_ application: UIApplication,
	didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
	self.viewStore.send(.appDelegate(.didRegisterForRemoteNotifications(.success(deviceToken))))
  }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification notification: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("\(#function)")
        completionHandler(.noData)
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        print("\(#function)")
        return false
    }

  func application(
	_ application: UIApplication,
	didFailToRegisterForRemoteNotificationsWithError error: Error
  ) {
	self.viewStore.send(
	  .appDelegate(.didRegisterForRemoteNotifications(.failure(error as NSError)))
	)
  }
}

@main
struct VEXAApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
  @Environment(\.scenePhase) private var scenePhase

  init() {

  }

  var body: some Scene {
	WindowGroup {
	  AppView(store: self.appDelegate.store)
	}
	//.onChange(of: self.scenePhase) {
	  //self.appDelegate.viewStore.send(.didChangeScenePhase($0))
	//}
  }
}

extension AppEnvironment {
  static var live: Self {
	let apiClient = ApiClient()
	let build = Build()

	return Self(
	  apiClient: apiClient,
	  applicationClient: .live,
	  backgroundQueue: DispatchQueue(label: "background-queue").eraseToAnyScheduler(),
	  build: build,
	  mainQueue: .main,
	  mainRunLoop: .main,
	  setUserInterfaceStyle: { userInterfaceStyle in
		.fireAndForget {
		  UIApplication.shared.windows.first?.overrideUserInterfaceStyle = userInterfaceStyle
		}
	  },
	  timeZone: { .autoupdatingCurrent }
	)
  }
}
