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
    
    public init(university: University, size: CGSize) {
        self.university = university
        self.size = size
    }
    
    let university: University
    let size: CGSize

    @ViewBuilder
    public var body: some View {
            HStack() {
                Image(university.universityLogos[0], bundle: .module)
                    .resizable()
                    .frame(width: 75, height: 75)
                    .cornerRadius(10)
                VStack(alignment: .leading) {
                    Text(university.universityName)
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
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10, style: .circular).stroke(Color(uiColor: .tertiaryLabel), lineWidth: 1)
            )
    }
    
    
}




