//
//  SwiftUIView.swift
//  
//
//  Created by Leonid Lyadveykin on 06.07.2022.
//

import SwiftUI
import Resources
import SharedModels

struct LikesView: View {
    let content: [DiscoveryModel]

    var body: some View {
        VStack {
            HStack(spacing: 5) {
                Button("liked", action: {
                    
                })
                Text(String(content.count))
                    .font(.callout)
                    .foregroundColor(.gray)
                Spacer()
            }
            
            likesView
        }

    }

    @ViewBuilder
    var likesView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack(spacing: 5) {
                HStack (spacing: 10) {
                    ForEach(content, id: \.self) { content in
                        Button(action: {
                            print("Process to liked content by student")
                        }) {
                            AsyncImage(url: content.image) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 85, height: 85)
                        }
                    }
                }
            }
        }
    }
}
