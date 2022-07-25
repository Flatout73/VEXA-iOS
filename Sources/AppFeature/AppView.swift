import ComposableArchitecture
import SharedModels
import SwiftUI
import MainFeature
import Profile
import Services
import Log
import UniversitiesList
import AddContent
import VEXAStreamChat
import Authorization

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
    var chatState: StreamChatState
    var universityListState: UniversityListState

    var authorizationState: AuthorizationState
    
    var selectedScreen = Screen.discovery

    var isAuthorizationShown = false
    
    public init(mainState: MainState = MainState(),
                profileState: ProfileState = ProfileState(user: nil),
                chatState: StreamChatState = StreamChatState(),
                universityListState: UniversityListState = UniversityListState(),
                authorizationState: AuthorizationState = AuthorizationState()
    ) {
        self.mainState = mainState
        self.profileState = profileState
        self.universityListState = universityListState
        self.chatState = chatState
        self.authorizationState = authorizationState
    }
}

public enum AppAction: Equatable {
    case appDelegate(AppDelegateAction)
    case main(MainAction)
    case profile(ProfileAction)
    case universityList(UniversityListAction)
    case chat(StreamChatAction)
    case authorization(AuthorizationAction)
    
    case changeScreen(AppState.Screen)
    case showAuth(Bool)
}

extension AppEnvironment {
    var main: MainEnvironment {
        MainEnvironment(apiClient: apiClient)
    }
    var profile: ProfileEnvironment {
        ProfileEnvironment(userService: userService)
    }
    
    var universityList: UniversityListEnvironment {
        UniversityListEnvironment(apiClient: apiClient)
    }

    var chat: StreamChatEnvironment {
        StreamChatEnvironment(apiClient: apiClient, userService: userService, streamChatService: streamChatService)
    }

    var authorization: AuthorizationEnvironment {
        AuthorizationEnvironment(apiClient: apiClient, tokenManager: tokenManager)
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

    streamChatReducerCore.pullback(state: \.chatState, action: /AppAction.chat,
                             environment: \.chat),

    authorizationReducerCore.pullback(state: \.authorizationState, action: /AppAction.authorization,
                                      environment: \.authorization),
    
    appReducerCore
)

let appReducerCore = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case .appDelegate:
        return .none
    case .main:
        return .none
    case .profile(let action):
        switch action {
        case .showLoginScreen:
            state.isAuthorizationShown = true
        case .logout:
            environment.tokenManager.authorizationToken = nil
        default:
            break
        }
    case .changeScreen(let screen):
        state.selectedScreen = screen
    case .universityList:
        return .none
    case .chat(_):
        return .none
    case .authorization(let action):
        switch action {
        case .updateCachedToken:
            return Effect(value: AppAction.profile(.onAppear))
        default:
            return .none
        }
    case .showAuth(let show):
        state.isAuthorizationShown = show
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

    @ViewBuilder
    var main: some View {
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

//            ChatView(store: store.scope(state: \.chatState, action: AppAction.chat))
            StreamChatView(store: store.scope(state: \.chatState, action: AppAction.chat))
                .tag(AppState.Screen.chat)
                .tabItem {
                    VStack {
                        if self.viewStore.selectedScreen == .chat {
                            Image(systemName: "message.fill")
                        } else {
                            Image(systemName: "message")
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
    }
    
    public var body: some View {
        main
            .sheet(isPresented: viewStore.binding(get: \.isAuthorizationShown, send: AppAction.showAuth)) {
                let authStore = self.store.scope(state: \.authorizationState, action: AppAction.authorization)
                AuthorizationView(store: authStore)
            }
            .onOpenURL { url in
                let screen = AppState.Screen(rawValue: url.host ?? "discovery") ?? .discovery
                viewStore.send(.changeScreen(screen))
            }
    }
}
