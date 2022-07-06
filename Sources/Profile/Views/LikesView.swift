//
//  SwiftUIView.swift
//  
//
//  Created by Leonid Lyadveykin on 06.07.2022.
//

import SwiftUI
import Resources

struct LikesView: View {
    let content: [URL]

    var body: some View {
        Group {
            Divider()
            HStack(spacing: 5) {
                Button("liked", action: {

                })
                Text(String(content.count))
                    .font(.callout)
                    .foregroundColor(.gray)
                    .bold()
                Spacer()
            }

            likesView

            Divider()
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
                            AsyncImage(url: content) { image in
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
