import SwiftUI
import ComposableArchitecture
import Analytics
import Log
import CoreUI
import SharedModels
import Resources
import ContentDetails
import CasePaths

public struct MainView: View {
	let store: Store<MainState, MainAction>

    @State
    private var search = ""

	public init(store: Store<MainState, MainAction>) {
		self.store = store
	}

    @ViewBuilder
    func backgroundNavigation(for cell: Discovery, viewStore: ViewStore<MainState, MainAction>) -> some View {
        NavigationLink(
            destination: IfLetStore(
                self.store.scope(
                    state: (\MainState.route).appending(path: /MainRoute.details).extract(from:),
                    action: MainAction.details
                ), then: { ContentDetailsView(store: $0) }),
            tag: MainRoute.details(ContentDetailsState(discovery: cell)),
            selection: viewStore.binding(
                get: \.route,
                send: MainAction.setNavigation
            )) {
                EmptyView()
            }
    }

	@ViewBuilder
    public var mainContent: some View {
        WithViewStore(self.store) { viewStore in
            GeometryReader { proxy in
                List {
                    //LazyVStack(spacing: 60) {
                    ForEach(viewStore.state.content) { cell in
                        let size = CGSize(width: proxy.size.width - 30, height: 400)
                        DiscoveryCollectionView(discovery: cell, size: size)
                            .listRowInsets(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .background(backgroundNavigation(for: cell, viewStore: viewStore))
                        }
                    //}
                    .padding(.bottom, 60)
                }
                .listStyle(PlainListStyle())
                .refreshable {
                    await viewStore.send(.fetchContent, while: \.isLoading)
                }
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
                    Image("filters", bundle: .module)
                })
            }
        }
    }

    public var body: some View {
        NavigationView {
            mainContent
                //.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .navigationViewStyle(StackNavigationViewStyle())
            .zIndex(0)
                .onAppear {
                    // just sample
                    //VEXAAnalytics.shared.log(event: "main_screen_appeared")
                    VEXALogger.shared.debug("main screen")
                }
        }

        .alert(self.store.scope(state: \.alert, action: MainAction.alert), dismiss: .dismiss)
    }
}
