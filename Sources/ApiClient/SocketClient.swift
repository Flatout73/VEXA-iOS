//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 28.06.2022.
//

import Foundation
import Protobuf
import Core

public class SocketClient: NSObject {
    var webSocket: URLSessionWebSocketTask?

    var isOpened = false

    public override init() {
        super.init()
    }

    public func openWebSocket() {
        let urlString = "ws://127.0.0.1:8080/chat"
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
            let webSocket = session.webSocketTask(with: request)
            webSocket.resume()
            self.webSocket = webSocket
            receiveMessage()
        }
    }

    func closeSocket() {
        webSocket?.cancel(with: .goingAway, reason: nil)
        webSocket = nil
        isOpened = false
    }

    public func send(message: WebSocketMessage) throws {
        let data = try message.jsonUTF8Data()
        webSocket?.send(URLSessionWebSocketTask.Message.data(data)) { [weak self] error in
            if let error = error {
                print("Failed with Error \(error.localizedDescription)")
            } else {
                //self?.closeSocket()
            }
        }
    }

    func receiveMessage() {

        guard isOpened else {
            return
        }

        webSocket?.receive(completionHandler: { [weak self] result in

            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let message):
                switch message {
                case .string(let messageString):
                    print(messageString)
                case .data(let data):
                    print(data.description)
                default:
                    print("Unknown type received from WebSocket")
                }
            }
            self?.receiveMessage()
        })
    }
}

extension SocketClient: URLSessionWebSocketDelegate {
    public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("Web socket opened")
        isOpened = true
        
        var message = WebSocketMessage()
        message.id = UUID().uuidString
        message.client = Constants.uuid.uuidString
        var content = ConnectMessage()
        content.connect = true
        message.content = WebSocketMessage.OneOf_Content.connectMessage(content)
        try? send(message: message)
    }


    public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("Web socket closed")
        isOpened = false
    }
}
