//
//  SwiftUIView.swift
//  
//
//  Created by Leonid Lyadveykin on 06.07.2022.
//

import SwiftUI
import SharedModels
import Resources

struct UniversitiesView: View {
    let universities: [UniversityModel]

    var body: some View {
        HStack(spacing: 5) {
            NavigationLink("universities", destination: {

            })
            .font(.callout)
            .foregroundColor(VEXAColors.mainGreen)
            Text(String(universities.count))
                .font(.callout)
                .foregroundColor(.gray)
                .bold()
                .frame(alignment: .leading)
            Spacer()
        }

        universitiesView
    }

    @ViewBuilder
    var universitiesView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack(spacing: 5) {

                HStack(spacing: 10) {
                    ForEach(universities) { uni in
                        VStack {
                            AsyncImage(url: uni.photos.first) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 85, height: 85, alignment: .center)
                            .clipped()
                            .cornerRadius(10)

                            Text(uni.name)
                                .font(.caption2)
                                .foregroundColor(VEXAColors.grayText)
                                .bold()
                        }
                    }
                }
            }

        }
    }
}
