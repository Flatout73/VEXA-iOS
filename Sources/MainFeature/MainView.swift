//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 16.02.2022.
//

import SwiftUI
import ComposableArchitecture
import Analytics
import Log
import CoreUI
import SharedModels

public struct MainView: View {
	let store: Store<MainState, MainAction>
	let namespace: Namespace.ID

	public init(store: Store<MainState, MainAction>, namespace: Namespace.ID) {
		self.store = store
		self.namespace = namespace
	}
    
    struct Discovery: Identifiable {
        var id: Int
        let ambassador, universityName, videoName, category, image: String
        
    }
    
    let discovery: [Discovery] = [
        Discovery(id: 0, ambassador: "Mark Codly", universityName: "University of Central Florida", videoName: "Video Name", category: "General Content", image: "heart.fill"),
        Discovery(id: 1, ambassador: "Pert First", universityName: "University of Tampa", videoName: "Dormatory", category: "Accomodation", image: "heart.fill"),
        Discovery(id: 0, ambassador: "Mark Codly", universityName: "University of Central Florida", videoName: "Video Name", category: "General Content", image: "heart.fill"),
        Discovery(id: 0, ambassador: "Mark Codly", universityName: "University of Central Florida", videoName: "Video Name", category: "General Content", image: "heart.fill"),
    ]

	@ViewBuilder
	public var mainContent: some View {
        
//		WithViewStore(self.store) { viewStore in
//            Text("\(viewStore.content.count)")
//                .task {
//                    await viewStore.send(.fetchContent, while: \.isLoading)
//                }
//		}
        
        NavigationView {
            Color.gray
            
            ScrollView (.horizontal) {
                HStack {
                    ForEach(discovery) { cell in
                        DiscoveryCollectionView(discovery: cell)
                    }
                }
            }
            .padding(20)
            .navigationTitle("Discovery Page")
            Spacer()
        }
	}
    
    struct DiscoveryCollectionView: View {

        let discovery: Discovery
        
        var body: some View {
            VStack {
                
                HStack {
                    Text("PIC")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    
                    VStack (alignment: .center) {
                        Text(discovery.videoName)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        Text(discovery.category)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .fontWeight(.none)
                        
                    }
                    
                    Text("4:24")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .center
                )
                .padding()
                .background(.gray)
                .cornerRadius(10)
                
                
                Image(systemName: "\(discovery.image)")
                        .resizable()
                        .cornerRadius(10)
                        .frame(width: 320, height: 500)
                HStack (spacing: 10) {
                    VStack {
                        HStack {
                            Text(discovery.ambassador)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                            Text("Ambassador")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Text(discovery.universityName)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Text("PIC")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .leading
                )
                .background(.white)
                .border(Color.gray, width: 2)
                .cornerRadius(10)
            }
            Spacer()
        }
    }

	public var body: some View {
		mainContent
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
		//.navigationViewStyle(StackNavigationViewStyle())
		//.zIndex(0)
			.onAppear {
				// just sample
				//VEXAAnalytics.shared.log(event: "main_screen_appeared")
				VEXALogger.shared.debug("main screen")
			}
			.alert(self.store.scope(state: \.alert, action: MainAction.alert), dismiss: .dismiss)
	}
}
