import ComposableArchitecture
import SharedModels
import SwiftUI
import MainFeature
import Profile
import Services
import Log
import UniversitiesList
import AddContent
import Chat

public struct AppState: Equatable {
    public enum Screen: String {
        case discovery
        case addContent
        case profile
        case chat
        case universityList
        case debug
    }
    var mainState: MainState
    var profileState: ProfileState
    var chatState: ChatState
    var universityListState: UniversityListState
    
    var selectedScreen = Screen.discovery
    
    public init(mainState: MainState = MainState(),
                profileState: ProfileState = ProfileState(),
                chatState: ChatState = ChatState(),
                universityListState: UniversityListState = UniversityListState()
    ) {
        self.mainState = mainState
        self.profileState = profileState
        self.universityListState = universityListState
        self.chatState = chatState
    }
}

public enum AppAction: Equatable {
    case appDelegate(AppDelegateAction)
    case main(MainAction)
    case profile(ProfileAction)
    case universityList(UniversityListAction)
    case chat(ChatAction)
    
    case changeScreen(AppState.Screen)
}

extension AppEnvironment {
    var main: MainEnvironment {
        MainEnvironment(apiClient: apiClient)
    }
    var profile: ProfileEnvironment {
        ProfileEnvironment()
    }
    
    var universityList: UniversityListEnvironment {
        UniversityListEnvironment()
    }

    var chat: ChatEnvironment {
        ChatEnvironment(apiClient: apiClient, socketClient: socketClient)
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

    chatReducerCore.pullback(state: \.chatState, action: /AppAction.chat,
                             environment: \.chat),
    
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
    case .universityList:
        return .none
    case .chat(_):
        return .none
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
                        Text("discovery")
                    }
                }
            // Engage
            UniversityListView(store: store.scope(state: \.universityListState, action: AppAction.universityList))
                .tag(AppState.Screen.universityList)
                .tabItem {
                    VStack {
                        if self.viewStore.selectedScreen == .universityList {
                            Image(systemName: "magnifyingglass.circle.fill")
                        } else {
                            Image(systemName: "magnifyingglass.circle")
                        }
                        Text("Engage")
                    }
                }
            
            
            // User Profile
            ProfileView(store: store.scope(state: \.profileState, action: AppAction.profile), isAmbassador: isAmbassador)
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

            ChatView(store: store.scope(state: \.chatState, action: AppAction.chat))
                .tag(AppState.Screen.chat)
                .tabItem {
                    VStack {
                        if self.viewStore.selectedScreen == .chat {
                            Image(systemName: "person.fill")
                        } else {
                            Image(systemName: "person")
                        }
                        Text("chat")
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
