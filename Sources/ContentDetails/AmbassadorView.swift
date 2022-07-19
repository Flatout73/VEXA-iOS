//
//  AmassadorView.swift
//  
//
//  Created by Leonid Lyadveykin on 19.07.2022.
//

import SwiftUI
import Protobuf
import SharedModels
import Resources

struct AmassadorView: View {

    let ambassador: DiscoveryModel.Ambassador
    let messageAction: () -> Void
    let universityAction: () -> Void

    var body: some View {

        Divider()

        HStack {
            AsyncImage(url: ambassador.imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 60)
            .clipped()
            .cornerRadius(10)

            VStack {
                HStack {
                    Text(ambassador.name)
                        .font(.subheadline)
                        .foregroundColor(VEXAColors.mainGreen)
                        .fontWeight(.bold)

                    Text("ambassador")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                Button(action: {
                    universityAction()

                }) {
                    Text(ambassador.universityName)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }

            Spacer()

            Button(action: {
                messageAction()

            }) {
                Image("Message", bundle: .module)
            }
            .buttonStyle(PlainButtonStyle())

        }

        Divider()
    }
}
