//
//  SwiftUIView.swift
//  
//
//  Created by Leonid Lyadveykin on 21.07.2022.
//

import SwiftUI
import StreamChat
import StreamChatSwiftUI
import ComposableArchitecture

public struct StreamChatView: View {
    let store: Store<StreamChatState, StreamChatAction>
    let viewStore: ViewStore<StreamChatState, StreamChatAction>

    @State
    private var chatView = ChatChannelListView(viewFactory: StreamCharViewFactory.shared)

    public init(store: Store<StreamChatState, StreamChatAction>) {
        self.store = store
        self.viewStore = ViewStore(store)
    }

    @ViewBuilder
    public var main: some View {
        if viewStore.hasUser {
            chatView
        } else {
            Text("No user")
        }
    }

    public var body: some View {
        main
            .onAppear {
                viewStore.send(.onAppear)
            }
    }
}
