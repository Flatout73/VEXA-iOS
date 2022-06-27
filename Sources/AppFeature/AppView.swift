import ComposableArchitecture
import SharedModels
import SwiftUI
import MainFeature
import Profile
import Services
import Log
import UniversitiesList
import AddContent

public struct AppState: Equatable {
    public enum Screen: String {
        case discovery
        case addContent
        case profile
        case universityList
        case debug
    }
    var mainState: MainState
    var profileState: ProfileState
   // var universityListState: UniversityListState
    
    var selectedScreen = Screen.discovery
    
    public init(mainState: MainState = MainState(),
                profileState: ProfileState = ProfileState()
    //            universityListState: UniversityListState = UniversityListState()
    ) {
        self.mainState = mainState
        self.profileState = profileState
        //self.universityListState = universityListState
    }
}

public enum AppAction: Equatable {
    case appDelegate(AppDelegateAction)
    case main(MainAction)
    case profile(ProfileAction)
    //case universityList(UniversityListAction)
    
    case changeScreen(AppState.Screen)
}

extension AppEnvironment {
    var main: MainEnvironment {
        MainEnvironment(apiClient: apiClient)
    }
    var profile: ProfileEnvironment {
        ProfileEnvironment()
    }
    
//    var universityList: UniversityListEnvironment {
//        UniversityListEnvironment()
//    }
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
//    case .universityList:
//        return .none
    }
    return .none
}

public struct AppView: View {
    let store: Store<AppState, AppAction>
    @ObservedObject
    var viewStore: ViewStore<AppState, AppAction>

    let isAmbassador: Bool
    
    public init(store: Store<AppState, AppAction>, isAmbassador: Bool = false) {
        self.store = store
        self.viewStore = ViewStore(store)
        self.isAmbassador = isAmbassador
    }
    
    public var body: some View {
        let mainStore: Store<MainState, MainAction> = store.scope(state: \.mainState, action: AppAction.main)
        TabView(selection: self.viewStore.binding(get: \.selectedScreen, send: AppAction.changeScreen)) {
            // Discovery
            MainView(store: mainStore)
                .tag(AppState.Screen.discovery)
                .tabItem {
                    VStack {
                        if self.viewStore.selectedScreen == .discovery {
                            Image(systemName: "house.fill")
                        } else {
                            Image(systemName: "house")
                        }
                        Text("discovery")
                    }
                }
            if isAmbassador {
                // Add video
                AddContentView()
                    .tag(AppState.Screen.addContent)
                    .tabItem {
                        VStack {
                            if self.viewStore.selectedScreen == .discovery {
                                Image(systemName: "plus.circle.fill")
                            } else {
                                Image(systemName: "plus")
                            }
                            Text("add_content")
                        }
                    }
                }
            // Engage
//            UniversityListView(store: store.scope(state: \.universityListState, action: AppAction.universityList))
//                .tag(AppState.Screen.universityList)
//                .tabItem {
//                    VStack {
//                        if self.viewStore.selectedScreen == .main {
//                            Image(systemName: "magnifyingglass.circle.fill")
//                        } else {
//                            Image(systemName: "magnifyingglass.circle")
//                        }
//                        Text("Engage")
//                    }
//                }
            
            
            // User Profile
            ProfileView(store: store.scope(state: \.profileState, action: AppAction.profile))
                .tag(AppState.Screen.profile)
                .tabItem {
                    VStack {
                        if self.viewStore.selectedScreen == .profile {
                            Image(systemName: "person.fill")
                        } else {
                            Image(systemName: "person")
                        }
                        Text("profile")
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
        .onOpenURL { url in
            let screen = AppState.Screen(rawValue: url.host ?? "discovery") ?? .discovery
            viewStore.send(.changeScreen(screen))
        }
    }
}
