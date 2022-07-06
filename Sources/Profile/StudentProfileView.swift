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

    
    @ViewBuilder
    var body: some View {
        VStack {
            
            Group {
                let nameComponents = PersonNameComponents(givenName: user.firstName, familyName: user.secondName)
                AvatarNameView(imageURL: user.imageURL, name: nameFormatter.string(from: nameComponents))

                Button("Message") {
                    VEXALogger.shared.debug("button pressed")
                }
                .buttonStyle(VEXAButtonStyle())
                
                AboutView(email: user.email,
                          dateOfBirth: user.dateOfBirth,
                          country: user.country,
                          nativeLanguage: user.nativeLanguage)
                
                Spacer()
                Divider()
                
               // UniversitiesView(universities: user.universities)
                
            }
            
        }
    }
    
}


