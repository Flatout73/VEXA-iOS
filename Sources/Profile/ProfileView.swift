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

public struct ProfileView: View {
	let store: Store<ProfileState, ProfileAction>

	public init(store: Store<ProfileState, ProfileAction>) {
		self.store = store
	}

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
