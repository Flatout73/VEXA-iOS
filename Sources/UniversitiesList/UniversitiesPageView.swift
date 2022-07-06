//
//  File.swift
//  
//
//  Created by Егор on 22.06.2022.
//

import SwiftUI
import Resources
import SharedModels

public struct UniversityPageView: View {
    
    public init(university: UniversityModel, size: CGSize) {
        self.university = university
        self.size = size
    }
    
    let university: UniversityModel
    let size: CGSize
    
    @ViewBuilder
    public var body: some View {
        VStack(alignment: .leading) {
            HStack() {
                AsyncImage(url: university.universityLogos.first) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 75, height: 75)
                .cornerRadius(10)
                VStack(alignment: .leading) {
                    Text(university.name)
                        .font(.title2)
                        .foregroundColor(.black)
                        .bold()
                    Text(university.type)
                        .font(.subheadline)
                        .foregroundColor(.black)
                    Text(university.contactInformation)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(VEXAColors.formBackground)
    }
    
    
}




