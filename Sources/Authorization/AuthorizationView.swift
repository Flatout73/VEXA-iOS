import SwiftUI
import ComposableArchitecture
import CoreUI
import SharedModels
import Resources

public struct AuthorizationView: View {
    let store: Store<AuthorizationState, AuthorizationAction>

    public init(store: Store<AuthorizationState, AuthorizationAction>) {
        self.store = store
    }

    @ViewBuilder
    public var mainContent: some View {
        WithViewStore(self.store) { viewStore in
            VStack(spacing: 16) {
                TextField("email", text: viewStore.binding(get: \.login, send: AuthorizationAction.changeLogin))
                TextField("password", text: viewStore.binding(get: \.password, send: AuthorizationAction.changePassword))

                    .padding()

                Button("Send") {
                    viewStore.send(.login)
                }
            }
        }
        .background(VEXAColors.background)
        .navigationBarTitleDisplayMode(.inline)
    }

    public var body: some View {
        NavigationView {
            mainContent
            .navigationViewStyle(StackNavigationViewStyle())
        }

        .alert(self.store.scope(state: \.alert, action: AuthorizationAction.alert), dismiss: .dismiss)
    }
}
