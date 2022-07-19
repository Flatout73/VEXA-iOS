//
//  SwiftUIView.swift
//  
//
//  Created by Leonid Lyadveykin on 19.07.2022.
//

import SwiftUI
import Resources

struct DescriptionView: View {
    @State
    private var showingSheet = false

    let description: String

    var body: some View {
        VStack(spacing: 4) {
            Text(description)
                .font(.body)
                .foregroundColor(.gray)
                .lineLimit(showingSheet ? nil : 6)
            
            Button(action: {
                showingSheet.toggle()
            }) {
                Text(showingSheet ? "Hide" : "See more")
                    .foregroundColor(VEXAColors.mainGreen)
                    .font(.subheadline)
            }

        }
    }
}
