//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 25.07.2022.
//

import StreamChat
import StreamChatSwiftUI
import SwiftUI

class StreamCharViewFactory: ViewFactory {

    @Injected(\.chatClient) public var chatClient

    private init() {}

    public static let shared = StreamCharViewFactory()

//    func makeChannelListHeaderViewModifier(title: String) -> some ChannelListHeaderViewModifier {
//        CustomChannelModifier(title: title)
//    }
}
