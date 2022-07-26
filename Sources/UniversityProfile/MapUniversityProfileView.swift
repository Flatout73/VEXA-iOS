//
//  File.swift
//  
//
//  Created by Егор on 26.07.2022.
//

import SwiftUI
import Resources
import SharedModels

public struct MapUniversityProfileView: View {
    
//    public init(university: UniversityModel) {
//        self.university = university
//    }
//
//    let university: UniversityModel
    
    @Binding
    var isPresented: Bool
    
    @ViewBuilder
    public var body: some View {
        VStack(alignment: .leading) {
            HStack() {
                //                AsyncImage(url: university.photos.first) { image in
                //                    image
                //                        .resizable()
                //                        .scaledToFill()
                //                } placeholder: {
                //                    ProgressView()
                //                }
                Image("Harper College", bundle: .module)
                    .resizable()
                    .frame(width: 75, height: 75)
                    .cornerRadius(10)
                VStack(alignment: .leading) {
                    Text("Harper College")
                        .font(.title2)
                        .foregroundColor(.black)
                        .bold()
                    Text("2 year, Public, community college")
                        .font(.subheadline)
                        .foregroundColor(.black)
                    Text("Palatine, IL, USA")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Button(action: {
                        isPresented = false
                        print("Close Button is pressed")
                    }) {
                        Image(systemName: "clear")
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(VEXAColors.formBackground)
    }
}





