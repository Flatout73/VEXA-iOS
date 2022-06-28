//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 28.06.2022.
//

import Foundation

public class SocketClient: NSObject {
    var webSocket: URLSessionWebSocketTask?

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
        }
    }
}

extension SocketClient: URLSessionWebSocketDelegate {
    public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("Web socket opened")
        //isOpened = true
    }


    public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("Web socket closed")
        ///isOpened = false
    }
}
