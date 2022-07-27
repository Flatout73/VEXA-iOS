//
//  VEXA_iOSApp.swift
//  Shared
//
//  Created by Leonid Lyadveykin on 14.02.2022.
//

import AppFeature
import ApiClient
import SwiftUI
import UIApplicationClient
import ComposableArchitecture
import Resources
import Services
import Profile

final class AppDelegate: NSObject, UIApplicationDelegate {
  let store = Store(
    initialState: AppState(profileState: ProfileState(user: AppEnvironment.live.userService.user)),
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

        let tabBarAppeareance = UITabBarAppearance()
        tabBarAppeareance.configureWithOpaqueBackground()
        tabBarAppeareance.shadowColor = .white // For line separator of the tab bar
        tabBarAppeareance.backgroundColor = .white

        UITabBar.appearance().standardAppearance = tabBarAppeareance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppeareance

        let navBarAppeareance = UINavigationBarAppearance()
        navBarAppeareance.configureWithOpaqueBackground()
        navBarAppeareance.backgroundColor = UIColor(VEXAColors.background)
        navBarAppeareance.shadowColor = UIColor(VEXAColors.background)
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppeareance
        UINavigationBar.appearance().standardAppearance = navBarAppeareance
        UINavigationBar.appearance().compactAppearance = navBarAppeareance

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
        let tokenManager = TokenManager()
        let apiClient = APIClient(tokenManager: tokenManager)
        let socketClient = SocketClient()

        return Self(
            apiClient: apiClient,
            tokenManager: tokenManager,
            socketClient: socketClient,
            streamChatService: StreamChatService(),
            userService: UserService(apiClient: apiClient),
            siwaService: SIWAService(),
            gidService: GIDService(),
            applicationClient: .live,
            backgroundQueue: DispatchQueue(label: "background-queue").eraseToAnyScheduler(),
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
