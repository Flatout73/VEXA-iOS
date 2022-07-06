//
//  File.swift
//  
//
//  Created by Егор on 30.06.2022.
//

import SwiftUI
import ComposableArchitecture
import Analytics
import Log
import CoreUI
import SharedModels
import Resources


public struct AmbassadorListView: View {
    
    public init(university: UniversityModel) {
        self.university = university
    }
    
    let university: UniversityModel
    
    @ViewBuilder
    public var mainContent: some View {
//        WithViewStore(self.store) { viewStore in
            GeometryReader { proxy in
                List {
                    ForEach(university.ambassadors, id: \.self) { cell in
                        let size = CGSize(width: proxy.size.width - 30, height: 100)
                        AmbassadorPageView(ambassador: cell, size: size)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
                            .listRowBackground(Color.clear)
                            .cornerRadius(20)
                            .padding(10)
                    }
                }
                .listStyle(PlainListStyle())
            }
//        }
        .background(VEXAColors.background)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    print("proceed to map with universities")
                }) {
                    Image("uniMap", bundle: .module)
                }
            }
        }
    }
    

    public var body: some View {
            mainContent
                //.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .navigationViewStyle(StackNavigationViewStyle())
            //.zIndex(0)
                .onAppear {
                    // just sample
                    //VEXAAnalytics.shared.log(event: "main_screen_appeared")
                    VEXALogger.shared.debug("main screen")
                }
    }
}
