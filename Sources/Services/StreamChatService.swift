//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 21.07.2022.
//

import Foundation
import StreamChat
import StreamChatSwiftUI
import Core
import SharedModels

public class StreamChatService: ObservableObject {

     lazy var chatClient: ChatClient = {
         //For the tutorial we use a hard coded api key and application group identifier
         var config = ChatClientConfig(apiKey: .init("66ayzsddmmdz"))
         //config.applicationGroupIdentifier = Constants.group

        
         let client = ChatClient(config: config)
         return client
     }()

    lazy var streamChat: StreamChat = StreamChat(chatClient: chatClient)

    let nameFormatter = PersonNameComponentsFormatter()

    public init() {
        _ = streamChat
    }

    public func connectUser(_ user: UserProtocol) {
        let nameComponents = PersonNameComponents(givenName: user.firstName, familyName: user.secondName)

        chatClient
            .connectUser(
                userInfo: .init(id: user.id,
                                name: nameFormatter.string(from: nameComponents),
                                imageURL: user.imageURL),
                token: Token.development(userId: user.id)
            ) { error in
                if let error = error {
                    // Some very basic error handling only logging the error.
                    log.error("connecting the user failed \(error)")
                    return
                }
        }
    }
}
