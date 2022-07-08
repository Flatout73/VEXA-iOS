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
    let viewStore: ViewStore<MainState, MainAction>

	public init(store: Store<MainState, MainAction>) {
		self.store = store
        self.viewStore = ViewStore(store)
	}

    @ViewBuilder
    func backgroundNavigation(for cell: DiscoveryModel, viewStore: ViewStore<MainState, MainAction>) -> some View {
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
        .searchable(text: Binding(get: {
            viewStore.state.searchText ?? ""
        }, set: {
            viewStore.send(MainAction.search($0, category: viewStore.state.category))
        }), prompt: "search")
        .background(VEXAColors.background)
        .navigationBarTitleDisplayMode(.inline)
    }

    public var body: some View {
        NavigationView {
            mainContent
                .navigationViewStyle(StackNavigationViewStyle())
                .zIndex(0)
                .onAppear {
                    // just sample
                    //VEXAAnalytics.shared.log(event: "main_screen_appeared")
                    VEXALogger.shared.debug("main screen")
                }
                .onOpenURL { url in
                    guard url.host == "discovery" else { return }
                    let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
                    if let id = urlComponents?.path, let content = viewStore.state.content.first(where: { "/\($0.id)" == id }) {
                        viewStore.send(.setNavigation(.details(ContentDetailsState(discovery: content))))
                    }
                }
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Menu(content: {
                            ForEach(ContentCategory.allCases) { category in
                                Button(action: {
                                    viewStore.send(.search(viewStore.state.searchText, category: category))
                                }, label: {
                                    Label(category.title, systemImage: "checkmark")
                                        .if(viewStore.state.category == category, transform: {
                                            $0
                                                .labelStyle(TitleAndIconLabelStyle())
                                        })
                                            .if(viewStore.state.category != category, transform: {
                                                $0
                                                    .labelStyle(TitleOnlyLabelStyle())
                                            })
                                })
                            }
                        }, label: {
                            Image("filters", bundle: .module)
                        })
                    }
                }
        }
        .alert(self.store.scope(state: \.alert, action: MainAction.alert), dismiss: .dismiss)
    }
}
