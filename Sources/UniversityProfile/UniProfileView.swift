//
//  File.swift
//  
//
//  Created by Егор on 20.06.2022.
//

import SwiftUI
import Resources
import SharedModels


public struct UniProfileView: View {
    
    public init(university: University) {
        self.university = university
    }
    
    
    let university: University

    @ViewBuilder
    public var body: some View {
        ScrollView (.vertical) {
            VStack() {
                TopView(university: university)
                ButtonView(university: university)
                
                Divider()
                VStack(alignment: .leading) {
                    HStack(spacing: 5) {
                        Text("Ambassadors")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(VEXAColors.mainGreen)
                            .frame(alignment: .leading)
                        Text("15")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .bold()
                            .frame(alignment: .leading)
                    }
                    AmbassadorsView(university: university)
                    Divider()
                    
                    HStack(spacing: 5) {
                        Text("Videos")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(VEXAColors.mainGreen)
                            .frame(alignment: .leading)
                        Text("15")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .bold()
                            .frame(alignment: .leading)
                    }
                    VideosView(university: university)
                    
                    Divider()
                    
                    UniversitySizeView(university: university)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    Divider()
                    
                    RequirementsView(university: university)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    
                    Group {
                        FacilitiesView(university: university)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        
                        MapView()
                            .frame(height: 110)
                        
                        ContactView(university: university)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
    
    
}




