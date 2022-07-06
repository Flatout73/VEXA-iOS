//
//  SwiftUIView.swift
//  
//
//  Created by Leonid Lyadveykin on 07.07.2022.
//

import SwiftUI

public struct AvatarNameView: View {
    let imageURL: URL?
    let name: String

    public init(imageURL: URL?, name: String) {
        self.imageURL = imageURL
        self.name = name
    }

    public var body: some View {
        HStack {
            // MARK: - Need to rewrite the image in AsyncImage
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
            }
            .frame(width: 85, height: 85)
            .clipped()
            .cornerRadius(10)


            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(name)
                        .foregroundColor(.black)
                        .font(.subheadline)
                        .fontWeight(.bold)
                }

                Text("Profile status")
                    .foregroundColor(.black)
                    .font(.subheadline)

            }
            Spacer()
        }
        .padding()
    }
}
