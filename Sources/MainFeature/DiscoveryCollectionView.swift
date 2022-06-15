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
    let size: CGSize

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
                
                Button(action: {
                    print("message button pressed")
                    
                }) {
                        Image("Message", bundle: .module)
                            .renderingMode(.original)
                            .foregroundColor(.gray)
                            
                }
                .buttonStyle(MyPrimitiveButtonStyle())
            }
            .padding()
            .background(.white)
            .cornerRadius(10)
            .alignmentGuide(.bottom) { d in d[.bottom] / 2 }
            .frame(width: size.width - 30, alignment: .bottom)
        }
    }
}


struct MyPrimitiveButtonStyle: PrimitiveButtonStyle {

    func makeBody(configuration: PrimitiveButtonStyle.Configuration) -> some View {
        MyButton(configuration: configuration)
    }

    struct MyButton: View {
        @GestureState private var pressed = false

        let configuration: PrimitiveButtonStyle.Configuration

        @State private var didTriggered = false

        var body: some View {
            
            let longPress = LongPressGesture(minimumDuration: 400, maximumDistance: 400.0)
                .updating($pressed) { value, state, _ in
                    state = value
                    self.configuration.trigger()
            }

            return configuration.label
                .opacity(pressed ? 0.2 : 1.0)
                .gesture(longPress)
        }
    }
}
