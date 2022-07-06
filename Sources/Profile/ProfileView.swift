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
import UniversityProfile
import UniversitiesList


public struct ProfileView: View {
	let store: Store<ProfileState, ProfileAction>
    let viewStore: ViewStore<ProfileState, ProfileAction>
    let isAmbassador: Bool

    @State
    private var showSettings = false

    public init(store: Store<ProfileState, ProfileAction>, isAmbassador: Bool) {
		self.store = store
        self.viewStore = ViewStore(store)
        self.isAmbassador = isAmbassador
	}
    
    let university = Mock.university

    public func main(for user: StudentModel) -> some View {
        ScrollView (.vertical) {
            VStack(spacing: 16) {
                if isAmbassador {
                    AmbassadorProfileView(content: [])
                } else {
                    StudentProfileView(user: user, isMyProfile: true)
                }

                Divider()

                Button("Logout") {
                    viewStore.send(.logout)
                }
                .buttonStyle(SecondaryButtonStyle(color: VEXAColors.red))
            }
            .padding()
            .background(VEXAColors.background)
        }
        .background(VEXAColors.background)
        .sheet(isPresented: $showSettings) {
            UserSettingsView(user: user)
        }
        .toolbar {
            Button(action: {
                showSettings = true
            }, label: {
                Image("editProfile", bundle: .module)
                    .foregroundColor(.gray)

            })
        }
        .navigationTitle("profile")
        .navigationBarTitleDisplayMode(.inline)
    }

    public var body: some View {
        NavigationView {
            if let user = viewStore.user {
                main(for: user)
            } else {
                placeholder
            }
        }
        .onAppear {
            viewStore.send(.onAppear)
        }
    }

    var placeholder: some View {
        Button("Login") {
            viewStore.send(.showLoginScreen)
        }
    }
}
