import SwiftUI
import ComposableArchitecture
import CoreUI
import SharedModels
import Resources
import AVKit

public struct ContentDetailsView: View {
    let store: Store<ContentDetailsState, ContentDetailsAction>

    public init(store: Store<ContentDetailsState, ContentDetailsAction>) {
        self.store = store
    }

    @ViewBuilder
    public var mainContent: some View {
        WithViewStore(self.store) { viewStore in
            if let url = viewStore.state.discovery.videoURL {
                VideoPlayer(player: AVPlayer(url: url))
                    .frame(height: 400)
            } else {
                Text("No video")
            }
        }
        .background(VEXAColors.background)
        .navigationBarTitleDisplayMode(.inline)
    }

    public var body: some View {
        mainContent
            .alert(self.store.scope(state: \.alert, action: ContentDetailsAction.alert), dismiss: .dismiss)
    }
}
