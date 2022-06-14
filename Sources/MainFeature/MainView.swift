import SwiftUI
import ComposableArchitecture
import Analytics
import Log
import CoreUI
import SharedModels
import Resources

public struct MainView: View {
	let store: Store<MainState, MainAction>

    @State
    private var search = ""

	public init(store: Store<MainState, MainAction>) {
		self.store = store
	}

	@ViewBuilder
    public var mainContent: some View {
        WithViewStore(self.store) { viewStore in
            GeometryReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 60) {
                        ForEach(viewStore.state.content) { cell in
                            let size = CGSize(width: proxy.size.width - 50, height: 400)
                            DiscoveryCollectionView(discovery: cell, size: size)
                        }
                    }
                    .padding(.bottom, 60)
                }
            }
            .task {
                await viewStore.send(.fetchContent, while: \.isLoading)
            }
        }
        .background(VEXAColors.background)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $search, prompt: "search")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Menu(content: {
                    Button("Category") {

                    }
                    Button("Ambassador") {

                    }
                }, label: {
                    Image(systemName: "list.dash")
                })
            }
        }
    }

    public var body: some View {
        NavigationView {
            mainContent
                //.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .navigationViewStyle(StackNavigationViewStyle())
            //.zIndex(0)
                .onAppear {
                    // just sample
                    //VEXAAnalytics.shared.log(event: "main_screen_appeared")
                    VEXALogger.shared.debug("main screen")
                }
        }

        .alert(self.store.scope(state: \.alert, action: MainAction.alert), dismiss: .dismiss)
    }
}
