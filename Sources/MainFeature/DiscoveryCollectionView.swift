//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 14.06.2022.
//

import SwiftUI
import SharedModels
import Resources

struct DiscoveryCollectionView: View {
    
    let discovery: DiscoveryModel
    let size: CGSize

    @ViewBuilder
    var overlay: some View {
        HStack {
            Image(systemName: "video")

            VStack(alignment: .center) {
                Text(discovery.videoName)
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text(discovery.category.title)
                    .font(.subheadline)
                    .fontWeight(.none)
            }

            Spacer()

            Text("4:24")
                .font(.subheadline)
                .fontWeight(.bold)

        }
        .foregroundColor(.white)
        .padding()
        .background(.black.opacity(0.34))
        .cornerRadius(radius: 10, corners: [.topLeft, .topRight])
    }

    var body: some View {
        
        ZStack(alignment: .bottom) {
            AsyncImage(url: discovery.image) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: size.width, height: size.height, alignment: .center)
            .clipped()
            .cornerRadius(10)
            .overlay(alignment: .top) {
                overlay
            }
            
            HStack(spacing: 10) {
                VStack {
                    HStack {
                        Text(discovery.ambassador.name)
                            .font(.subheadline)
                            .foregroundColor(VEXAColors.mainGreen)
                            .fontWeight(.bold)
                        Text("Ambassador")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Text(discovery.universityName)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()

                Button(action: {
                    print("message button pressed")
                    
                }) {
                    Image("Message", bundle: .module)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding()
            .background(.white)
            .cornerRadius(10)
            .alignmentGuide(.bottom) { d in d[.bottom] / 2 }
            .frame(width: size.width - 30, alignment: .bottom)
        }
    }
}
