import SwiftUI
import ComposableArchitecture
import CoreUI
import SharedModels
import Resources

public struct ChatView: View {
    let store: Store<ChatState, ChatAction>

    public init(store: Store<ChatState, ChatAction>) {
        self.store = store
    }

    @ViewBuilder
    public var mainContent: some View {
        WithViewStore(self.store) { viewStore in
            Text("")
                .onAppear {
                    viewStore.send(.connect)
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
        .alert(self.store.scope(state: \.alert, action: ChatAction.alert), dismiss: .dismiss)
    }
}
