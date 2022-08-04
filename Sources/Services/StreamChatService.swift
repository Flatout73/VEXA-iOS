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
         config.applicationGroupIdentifier = Constants.group

         let client = ChatClient(config: config)
         return client
     }()

    lazy var streamChat: StreamChat = StreamChat(chatClient: chatClient)

    let nameFormatter = PersonNameComponentsFormatter()

    var userID: String?

    public init() {
        _ = streamChat
    }

    public func connectUser(_ user: UserProtocol, streamToken: String) {
        let nameComponents = PersonNameComponents(givenName: user.firstName, familyName: user.secondName)
        self.userID = user.id
        chatClient
            .connectUser(
                userInfo: .init(id: user.id,
                                name: nameFormatter.string(from: nameComponents),
                                imageURL: user.imageURL),
                token: try! Token(rawValue: streamToken)
            ) { error in
                if let error = error {
                    // Some very basic error handling only logging the error.
                    log.error("connecting the user failed \(error)")
                    return
                }
        }
    }

    public func createChannel(for ambassadorID: String) async throws -> String? {
        let set = Set([userID, ambassadorID].compactMap { $0 })
        return try await withCheckedThrowingContinuation { continuiation in
            do {
                let channel = try chatClient.channelController(createDirectMessageChannelWith: set,
                                                               extraData: [:])

                channel
                    .synchronize { error in
                        if let error = error {
                            continuiation.resume(throwing: error)
                        } else {
                            continuiation.resume(returning: channel.cid?.id)
                        }
                    }
            } catch {
                continuiation.resume(throwing: error)
            }
        }
    }

    public func channelInfo(by id: String) -> ChannelSelectionInfo? {
        if let channelId = try? ChannelId(cid: id) {
            let chatController = chatClient.channelController(
                for: channelId,
                messageOrdering: .topToBottom
            )
            return chatController.channel?.channelSelectionInfo
        }

        return nil
    }
}
