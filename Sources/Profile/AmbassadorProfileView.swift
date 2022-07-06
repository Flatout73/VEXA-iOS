//
//  SwiftUIView.swift
//  
//
//  Created by Leonid Lyadveykin on 07.07.2022.
//

import SwiftUI
import Resources
import SharedModels

struct AmbassadorProfileView: View {
    let content: [DiscoveryModel]
    var body: some View {
        Divider()

        HStack(spacing: 5) {
            Text("My Content")
                .font(Font.system(size: 14))
                .foregroundColor(VEXAColors.mainGreen)
                .bold()
                .frame(alignment: .leading)
            Text("15")
                .font(Font.system(size: 14))
                .foregroundColor(.gray)
                .bold()
                .frame(alignment: .leading)
            Spacer()
        }

        studentContentView()
    }

    // MARK: - Horizontal Scroll View with Content

    func studentContentView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack(spacing: 5) {
                HStack (spacing: 10) {
                    ForEach(content, id: \.self) { content in
                        Button(action: {
                            print("Process to content")
                        }) {
                            AsyncImage(url: content.image) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 85, height: 85)
                            .clipped()
                        }
                    }
                }
            }
        }
    }
}
