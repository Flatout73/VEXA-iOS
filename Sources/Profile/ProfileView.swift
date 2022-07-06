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

    // MARK: - Horizontal Scroll View with Content

//    func studentContentView(for user: StudentModel) -> some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            VStack(spacing: 5) {
//                HStack (spacing: 10) {
//                    ForEach(user.content, id: \.self) { content in
//                        Button(action: {
//                            print("Process to content")
//                        }) {
//                            Image(content, bundle: .module)
//                                .resizable()
//                                .frame(width: 85, height: 85)
//                        }
//                    }
//                }
//            }
//        }
//    }

    public func main(for user: StudentModel) -> some View {
        ScrollView (.vertical) {
            VStack(spacing: 16) {
                UserProfileView(user: user)
                    .padding()
                    .background(VEXAColors.background)

                if isAmbassador {
                    Divider()

                    HStack(spacing: 5) {
                        Text("My Content")
                            .font(Font.system(size: 14))
                            .foregroundColor(VEXAColors.mainGreen)
                            .bold()
                            .frame(alignment: .leading)
                        Text("15")
                            .font(Font.system(size: 14))
                            .foregroundColor(.gray)
                            .bold()
                            .frame(alignment: .leading)
                        Spacer()
                    }

                    //studentContentView(for: user)
                }
            }
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
