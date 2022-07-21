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

public class StreamChatService: ObservableObject {

     lazy var chatClient: ChatClient = {
         //For the tutorial we use a hard coded api key and application group identifier
         var config = ChatClientConfig(apiKey: .init("66ayzsddmmdz"))
         //config.applicationGroupIdentifier = Constants.group

        
         let client = ChatClient(config: config)
         return client
     }()

    lazy var streamChat: StreamChat = StreamChat(chatClient: chatClient)

    public init() {
        _ = streamChat
        connectUser()
    }

    func connectUser() {
            // This is a hardcoded token valid on Stream's tutorial environment.
            let token = try! Token(rawValue: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMTIzIn0.F2kBYIOUAPAr5aNDEOLw7kogenxLFQb6NjTcp9sth38")

            // Call `connectUser` on our SDK to get started.
            chatClient.connectUser(
                    userInfo: .init(id: "123",
                                    name: "Leo",
                                    imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/2/20/LukeTLJ.jpg")!),
                    token: token
            ) { error in
                if let error = error {
                    // Some very basic error handling only logging the error.
                    log.error("connecting the user failed \(error)")
                    return
                }
            }
        }
}
