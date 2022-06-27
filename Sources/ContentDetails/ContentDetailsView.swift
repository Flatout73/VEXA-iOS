import SwiftUI
import ComposableArchitecture
import CoreUI
import SharedModels
import Resources
import AVKit

public struct ContentDetailsView: View {
    let store: Store<ContentDetailsState, ContentDetailsAction>

    @State
    private var isShareSheetShown = false

    public init(store: Store<ContentDetailsState, ContentDetailsAction>) {
        self.store = store
    }

    @ViewBuilder
    public var mainContent: some View {
        WithViewStore(self.store) { viewStore in
            VStack(spacing: 0) {
                if let url = viewStore.state.discovery.videoURL {
                    VideoPlayer(player: AVPlayer(url: url))
                        .frame(height: 250)
                } else {
                    Text("No video")
                }
                ScrollView {
                    VStack {
                        Text(viewStore.state.discovery.desctription)
                            .font(.body)
                            .padding()
                    }
                }
            }
            .toolbar {
                Button(action: {
                    isShareSheetShown = true
                }, label: {
                    Image(systemName: "square.and.arrow.up")
                })
            }
            .sheet(isPresented: $isShareSheetShown) {
                return ShareSheet(activityItems: [URL(string: "vexa://video/\(viewStore.state.discovery.id)")])
            }
        }
        .background(VEXAColors.background)

    }

    public var body: some View {
        mainContent
            .alert(self.store.scope(state: \.alert, action: ContentDetailsAction.alert), dismiss: .dismiss)
            .navigationBarTitleDisplayMode(.inline)
    }
}
