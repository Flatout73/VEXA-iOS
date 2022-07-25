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

    public init(store: Store<StreamChatState, StreamChatAction>) {
        self.store = store
        self.viewStore = ViewStore(store)
    }

    @ViewBuilder
    public var main: some View {
        if viewStore.hasUser {
            ChatChannelListView(viewFactory: StreamCharViewFactory.shared,
                                viewModel: viewStore.chatViewModel,
                                title: "Chat")
        } else {
            Text("No user")
        }
    }

    public var body: some View {
        main
            .onAppear {
                viewStore.send(.onAppear)
            }
            .onDisappear {
                viewStore.send(.clearChannel)
            }
            .onOpenURL { url in
                guard url.host == "chat" else { return }
                let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
                if let id = urlComponents?.path.replacingOccurrences(of: "/", with: "") {
                    DispatchQueue.main.asyncAfter(deadline: .now().advanced(by: .milliseconds(300))) {
                        viewStore.send(.showChannel(id: id))
                    }
                }
            }
    }
}
