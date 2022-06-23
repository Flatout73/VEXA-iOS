//
//  SwiftUIView.swift
//  
//
//  Created by Leonid Lyadveykin on 23.06.2022.
//

import SwiftUI
import AVKit
import SharedModels

struct ContentView: View {
    let discovery: Discovery

    var body: some View {
        if let url = discovery.videoURL {
            VideoPlayer(player: AVPlayer(url: url))
                .frame(height: 400)
        } else {
            Text("No video")
        }
    }
}
