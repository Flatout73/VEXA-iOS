//
//  File.swift
//  
//
//  Created by Егор on 20.06.2022.
//

import SwiftUI
import ComposableArchitecture
import CoreUI
import SharedModels
import Resources
import AVKit

public struct UniProfileView: View {
    
    public init(university: Store<UniversityState, UniversityAction>) {
        self.university = university
    }
    
    let university: Store<UniversityState, UniversityAction>
    
    @ViewBuilder
    public var main: some View {
        WithViewStore(self.university) { viewStore in
            
            ScrollView (.vertical) {
                VStack() {
                    TopView(university: viewStore.state.content)
                    ButtonView(university: viewStore.state.content)
                    
                    Divider()
                    VStack(alignment: .leading) {
                        HStack(spacing: 5) {
                            
                            NavigationLink(destination: AmbassadorListView(university: viewStore.state.content)) {
                                
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
                        AmbassadorsView(university: viewStore.state.content)
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
                        VideosView(university: viewStore.state.content)
                        
                        Divider()
                        
                        UniversitySizeView(university: viewStore.state.content)
                        
                        Divider()
                        
                        RequirementsView(university: viewStore.state.content)
                        
                        
                        Group {
                            Divider()
                            
                            FacilitiesView(university: viewStore.state.content)
                            
                            Divider()
                            
                            PriceView(university: viewStore.state.content)
                            
                            Divider()
                            
                            MapView()
                                .frame(height: 110)
                            
                            Divider()
                            
                            ContactView(university: viewStore.state.content)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }
        }
        .padding()
        .background(VEXAColors.background)
    }
    
    public var body: some View {
        
        main
            .toolbar {
                
            }
            .navigationTitle("university.name")
            .navigationBarTitleDisplayMode(.inline)
    }
}




