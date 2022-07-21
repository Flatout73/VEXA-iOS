import SwiftUI
import ComposableArchitecture
import CoreUI
import SharedModels
import Resources
import AuthenticationServices

public struct AuthorizationView: View {
    let store: Store<AuthorizationState, AuthorizationAction>

    @Environment(\.dismiss)
    var dismiss

    public init(store: Store<AuthorizationState, AuthorizationAction>) {
        self.store = store
    }

    @ViewBuilder
    public var mainContent: some View {
        WithViewStore(self.store) { viewStore in
            ScrollView {
                VStack(spacing: 38) {
                    LogoView()

                    VStack(spacing: 16) {
                        TextField("email", text: viewStore.binding(get: \.login, send: AuthorizationAction.changeLogin))
                            .textFieldStyle(VEXATextFieldStyle())
                        TextField("password", text: viewStore.binding(get: \.password, send: AuthorizationAction.changePassword))
                            .textFieldStyle(VEXATextFieldStyle())
                    }

                    Button("log_in") {
                        viewStore.send(.login)
                    }
                    .buttonStyle(VEXAButtonStyle())

                    Text("or")

                    SignInWithAppleButton(.signIn) { request in
                        request.requestedScopes = [.fullName, .email]
                    } onCompletion: { result in
                        switch result {
                        case .success(let authResults):
                            viewStore.send(.handleSIWALogin(authResults))
                        case .failure(let error):
                            viewStore.send(.showError(error.localizedDescription))
                        }
                    }
                }
                .padding()
            }
            .onChange(of: viewStore.token, perform: { token in
                if token != nil {
                    dismiss()
                }
            })
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction, content: {
                Button("back", action: {
                    dismiss()
                })
            })
        }
    }

    public var body: some View {
        NavigationView {
            mainContent
                .background(VEXAColors.background)
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .alert(self.store.scope(state: \.alert, action: AuthorizationAction.alert), dismiss: .dismiss)
    }
}
