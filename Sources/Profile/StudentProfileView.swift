//
//  SwiftUIView.swift
//  
//
//  Created by Егор on 16.06.2022.
//

import SwiftUI
import SharedModels
import Resources
import Log
import CoreUI
import Core

struct StudentProfileView: View {
    let user: StudentModel
    let isMyProfile: Bool

    @ViewBuilder
    var body: some View {
        VStack(spacing: 16) {
            let nameComponents = PersonNameComponents(givenName: user.firstName, familyName: user.secondName)
            AvatarNameView(imageURL: user.imageURL, name: nameFormatter.string(from: nameComponents),
                           profileStatus: user.status.title)

            if !isMyProfile {
                Button("Message") {
                    VEXALogger.shared.debug("button pressed")
                }
                .buttonStyle(VEXAButtonStyle())
            }

            AboutView(email: user.email,
                      dateOfBirth: user.dateOfBirth,
                      country: user.country,
                      nativeLanguage: user.nativeLanguage)

            Divider()

            // UniversitiesView(universities: user.universities)

            LikesView(content: user.likes)
        }
    }
}


