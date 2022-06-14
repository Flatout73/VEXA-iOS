//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 14.06.2022.
//

import SwiftUI
import SharedModels

struct DiscoveryCollectionView: View {

    let discovery: Discovery

    @ViewBuilder
    var overlay: some View {
        HStack {
            Image(systemName: "video")

            VStack(alignment: .center) {
                Text(discovery.videoName)
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text(discovery.category)
                    .font(.subheadline)
                    .fontWeight(.none)
            }

            Spacer()

            Text("4:24")
                .font(.subheadline)
                .fontWeight(.bold)

        }
        .foregroundColor(.white)
        .background(.black.opacity(0.34))
        .cornerRadius(radius: 10, corners: [.topLeft, .topRight])
    }

    var body: some View {
        ZStack(alignment: .bottom) {
                AsyncImage(url: discovery.image) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .cornerRadius(10)
                .clipped()

            HStack(spacing: 10) {
                VStack {
                    HStack {
                        Text(discovery.ambassador)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                        Text("Ambassador")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Text(discovery.universityName)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                Spacer()

                Text("PIC")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
            }
            .background(.white)
            .border(Color.gray, width: 2)
            .cornerRadius(10)
            .alignmentGuide(.bottom) { d in d[.bottom] / 2 }
        }
        .overlay(alignment: .top) {
            overlay
        }
        .padding(EdgeInsets(top: 20, leading: 25, bottom: 40, trailing: 25))
    }
}
