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
    
    public init(university: University) {
        self.university = university
    }
    
    
    let university: University
    let size: CGSize

    @ViewBuilder
    public var body: some View {
        HStack {
            Image(university.universityLogos[0], bundle: .module)
                .resizable()
                .frame(width: 75, height: 75)
            VStack {
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
        
        
    }
    
    
}




