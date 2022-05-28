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

	@ViewBuilder
	public var mainContent: some View {
		WithViewStore(self.store) { viewStore in
            Text("kek")
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
				Log.logger.debug("main screen")
			}
			.alert(self.store.scope(state: \.alert, action: MainAction.alert), dismiss: .dismiss)
	}
}
