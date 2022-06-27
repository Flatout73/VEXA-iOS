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


public struct UniversityListView: View {
    let store: Store<UniversityListState, UniversityListAction>
    
    
    @State
    private var search = ""
    
    public init(store: Store<UniversityListState, UniversityListAction>) {
        self.store = store
    }
    
    @ViewBuilder
    public var mainContent: some View {
        WithViewStore(self.store) { viewStore in
            GeometryReader { proxy in
                List {
                    ForEach(viewStore.state.content) { cell in
                        let size = CGSize(width: proxy.size.width - 30, height: 100)
                        UniversityPageView(university: cell, size: size)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
                            .listRowBackground(Color.clear)
                            .padding(10)
                            .background(
                                NavigationLink("") {
                                    UniProfileView(university: cell)
                                }
                                    .opacity(0)
                            )
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .background(VEXAColors.background)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $search, prompt: "search")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    print("proceed to map with universities")
                }) {
                    Image("uniMap", bundle: .module)
                }
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
    
    }
}
