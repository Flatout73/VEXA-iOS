//
//  File.swift
//  
//
//  Created by Егор on 23.06.2022.
//

import SwiftUI
import ComposableArchitecture
import Analytics
import Log
import CoreUI
import SharedModels
import Resources
import UniversityProfile
import AVKit

public struct UniversityListView: View {
    let store: Store<UniversityListState, UniversityListAction>
    let viewStore: ViewStore<UniversityListState, UniversityListAction>
    
    @State
    private var showMap = false
    
    public init(store: Store<UniversityListState, UniversityListAction>) {
        self.store = store
        self.viewStore = ViewStore(store)
    }
    
    @ViewBuilder
    func backgroundNavigationForUni(for cell: UniversityModel) -> some View {
        NavigationLink(
            destination: IfLetStore(
                self.store.scope(
                    state: (\UniversityListState.route).appending(path: /UniversityListRoute.details).extract(from:),
                    action: UniversityListAction.details
                ), then: { UniProfileView(university: $0) }),
            tag: UniversityListRoute.details(UniversityState(content: cell)),
            selection: viewStore.binding(
                get: \.route,
                send: UniversityListAction.setNavigation
            )) {
                EmptyView()
            }
    }
    
    @ViewBuilder
    public var mainContent: some View {
            List {
                ForEach(viewStore.state.filteredContent ?? viewStore.state.content) { cell in
//                    let size = CGSize(width: proxy.size.width - 30, height: 100)
                    UniversityPageView(university: cell)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
                        .listRowBackground(Color.clear)
                        .cornerRadius(20)
                        .padding(10)
                        .background(backgroundNavigationForUni(for: cell))
                }
            }
            .listStyle(PlainListStyle())
            .refreshable {
                await viewStore.send(.fetchContent, while: \.isLoading)
            }
//        .searchable(text: viewStore.binding(get: \.searchText, send: UniversityListAction.search), prompt: "search")
            .searchable(text: Binding(get: {
                viewStore.state.searchText ?? ""
            }, set: {
                viewStore.send(UniversityListAction.search($0))
            }), prompt: "search")
        
        .background(VEXAColors.background)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showMap) {
            MapView()
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    showMap = true
                    print("proceed to map with universities")
                }) {
                    Image("uniMap", bundle: .module)
                }
            }
        }
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
                }
                .onOpenURL { url in
                    guard url.host == "universities" else { return }
                    let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
                    if let id = urlComponents?.path, let content = viewStore.state.content.first(where: { "/\($0.id)" == id }) {
                        viewStore.send(.setNavigation(.details(UniversityState(content: content))))
                    }
                }
        }
    
    }
}


