import ComposableArchitecture
import SharedModels
import SwiftUI
import MainFeature
import Profile
import Services
import Log

public struct AppState: Equatable {
    public enum Screen: String {
        case main
        case profile
        case debug
    }
    var mainState: MainState
    var profileState: ProfileState
    
    var selectedScreen = Screen.main
    
    public init(mainState: MainState = MainState(), profileState: ProfileState = ProfileState()) {
        self.mainState = mainState
        self.profileState = profileState
    }
}

public enum AppAction: Equatable {
    case appDelegate(AppDelegateAction)
    case main(MainAction)
    case profile(ProfileAction)
    
    case changeScreen(AppState.Screen)
}

extension AppEnvironment {
    var main: MainEnvironment {
        MainEnvironment(apiClient: apiClient)
    }
    var profile: ProfileEnvironment {
        ProfileEnvironment()
    }
}

public let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
    mainReducer.pullback(
        state: \AppState.mainState,
        action: /AppAction.main,
        environment: \.main),
    
    profileReducer.pullback(
        state: \.profileState,
        action: /AppAction.profile,
        environment: \.profile),
    
    appReducerCore
)

let appReducerCore = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case .appDelegate:
        return .none
    case .main:
        return .none
    case .profile(_):
        return .none
    case .changeScreen(let screen):
        state.selectedScreen = screen
    }
    return .none
}

public struct AppView: View {
    let store: Store<AppState, AppAction>
    @ObservedObject
    var viewStore: ViewStore<AppState, AppAction>
    
    public init(store: Store<AppState, AppAction>) {
        self.store = store
        self.viewStore = ViewStore(store)
    }
    
    public var body: some View {
        let mainStore: Store<MainState, MainAction> = store.scope(state: \.mainState, action: AppAction.main)
        TabView(selection: self.viewStore.binding(get: \.selectedScreen, send: AppAction.changeScreen)) {
            MainView(store: mainStore)
                .tag(AppState.Screen.main)
                .tabItem {
                    VStack {
                        if self.viewStore.selectedScreen == .main {
                            Image(systemName: "house.fill")
                        } else {
                            Image(systemName: "house")
                        }
                        Text("discovery")
                    }
                }
            ProfileView(store: store.scope(state: \.profileState, action: AppAction.profile))
                .tag(AppState.Screen.profile)
                .tabItem {
                    VStack {
                        if self.viewStore.selectedScreen == .profile {
                            Image(systemName: "person.fill")
                            Text("profileSelected")
                        } else {
                            Image(systemName: "person")
                            Text("profile")
                        }
                    }
                }
            #if DEBUG
            DebugView()
                .tag(AppState.Screen.debug)
                .tabItem {
                    VStack {
                        Image(systemName: "gear")
                        Text("Debug")
                    }
                }
            #endif
        }
    }
}
