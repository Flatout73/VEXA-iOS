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
    public var main: some View {
        ScrollView (.vertical) {
            VStack() {
                TopView(university: university)
                ButtonView(university: university)
                
                Divider()
                VStack(alignment: .leading) {
                    HStack(spacing: 5) {
                        
                        NavigationLink(destination: AmbassadorListView(university: university)) {
                            
                            Text("Ambassadors")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(VEXAColors.mainGreen)
                                .frame(alignment: .leading)
                        }
                        Text("15")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .bold()
                            .frame(alignment: .leading)
                    }
                    AmbassadorsView(university: university)
                    Divider()
                    
                    HStack(spacing: 5) {
                        Button(action: {
                            print("Videos screen proceed")
                        }) {
                            Text("Videos")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(VEXAColors.mainGreen)
                                .frame(alignment: .leading)
                        }
                        Text("15")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .bold()
                            .frame(alignment: .leading)
                    }
                    VideosView(university: university)
                    
                    Divider()
                    
                    UniversitySizeView(university: university)
                        
                    Divider()
                    
                    RequirementsView(university: university)
                    
                    
                    Group {
                        Divider()
                        
                        FacilitiesView(university: university)
                        
                        Divider()
                        
                        PriceView(university: university)

                        Divider()
                        
                        MapView()
                            .frame(height: 110)
                        
                        Divider()
                        
                        ContactView(university: university)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .padding()
        .background(VEXAColors.background)
    }
    
    public var body: some View {
        NavigationView {
            main
                .toolbar {
                    
                }
                .navigationTitle(university.universityName)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    
}




