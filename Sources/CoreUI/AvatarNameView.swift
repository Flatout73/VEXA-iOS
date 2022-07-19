//
//  SwiftUIView.swift
//  
//
//  Created by Leonid Lyadveykin on 07.07.2022.
//

import SwiftUI
import Resources

public struct AvatarNameView: View {
    let imageURL: URL?
    let name: String
    let profileStatus: LocalizedStringKey?

    public init(imageURL: URL?, name: String, profileStatus: LocalizedStringKey?) {
        self.imageURL = imageURL
        self.name = name
        self.profileStatus = profileStatus
    }

    public var body: some View {
        HStack {
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
                        .font(.headline)
                }

                if let profileStatus = profileStatus {
                    Text(profileStatus)
                }
            }
            .foregroundColor(VEXAColors.text)
            .font(.subheadline)
            Spacer()
        }
        .padding(.horizontal, 5)
    }
}
