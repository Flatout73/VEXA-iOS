import SwiftUI
import ComposableArchitecture
import CoreUI
import SharedModels
import Resources

public struct EditProfileInfoView: View {
    let store: Store<EditProfileInfoState, EditProfileInfoAction>

    public init(store: Store<EditProfileInfoState, EditProfileInfoAction>) {
        self.store = store
    }

    @ViewBuilder
    public var mainContent: some View {
        WithViewStore(self.store) { viewStore in
            ScrollView {
                TopView(user: viewStore.user)
                Divider()
                GeneralInfoView(viewStore: viewStore)
                    .padding()
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

        .alert(self.store.scope(state: \.alert, action: EditProfileInfoAction.alert), dismiss: .dismiss)
    }
}
