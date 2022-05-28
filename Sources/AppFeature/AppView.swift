import ComposableArchitecture
import SharedModels
import SwiftUI
import MainFeature
import Profile
import Services

public struct AppState: Equatable {
    public enum Screen: String {
        case main
        case profile
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
    var profile: ProfileEnvironment {
        ProfileEnvironment()
    }
}

public let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
    mainReducer.pullback(
        state: \AppState.mainState,
        action: /AppAction.main,
        environment: { _ in MainEnvironment() }),
    
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
    
    @Namespace
    private var namespace
    
    public init(store: Store<AppState, AppAction>) {
        self.store = store
        self.viewStore = ViewStore(store)
    }
    
    public var body: some View {
        let mainStore: Store<MainState, MainAction> = store.scope(state: \.mainState, action: AppAction.main)
        TabView(selection: self.viewStore.binding(get: \.selectedScreen, send: AppAction.changeScreen)) {
            MainView(store: mainStore, namespace: namespace)
                .tag(AppState.Screen.main)
                .tabItem {
//                    VStack {
//                        Text("")
                        if self.viewStore.selectedScreen == .main {
                            Text("homeSelected")
                        } else {
                            Text("home")
                        }
//                    }
                }
            ProfileView(store: store.scope(state: \.profileState, action: AppAction.profile))
                .tag(AppState.Screen.profile)
                .tabItem {
//                    VStack {
//                        Text("")
                        if self.viewStore.selectedScreen == .profile {
                            Text("profileSelected")
                        } else {
                            Text("profile")
                        }
  //                  }
                }
        }
    }
}
