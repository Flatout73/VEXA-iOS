//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 16.02.2022.
//

import SwiftUI
import ComposableArchitecture
import CoreUI
import Resources
import SharedModels

public struct ProfileView: View {
	let store: Store<ProfileState, ProfileAction>

	public init(store: Store<ProfileState, ProfileAction>) {
		self.store = store
	}
    
    let user = User(id: "0", firstName: "Leonid", secondName: "Leonidovich", email: "Leonid@mail.ru", dateOfBirth: "04.04.1944", country: "Russia", nativeLanguage: "Russian", universities: ["University Name", "University Name2"], content: ["Jane", "aboutIMG"], image: URL(string: "https://i.stack.imgur.com/e54hT.png"))
    
	public var body: some View {
		WithViewStore(store) { viewStore in
			VStack(alignment: .center) {
				Picker("Screen", selection: viewStore.binding(get: \.screen, send: ProfileAction.changeTo)) {
					ForEach(ProfileState.Screen.allCases) { 
						Text(LocalizedStringKey($0.title))
							.tag($0)
					}
				}
				.pickerStyle(.segmented)

				Spacer()

                switch viewStore.screen {
                    // TODO: Add separate modules for every screen
                case .heal:
                    UserProfile(user: user)
                case .stage:
                    Text("kekes")
                default:
                    EmptyView()
                }
			}
			.padding()
		}
	}
}
