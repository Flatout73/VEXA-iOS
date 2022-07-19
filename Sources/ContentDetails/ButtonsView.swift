//
//  File.swift
//  
//
//  Created by Егор on 05.07.2022.
//

import SwiftUI
import SharedModels
import Resources
import CoreUI

struct ButtonsView: View {
    
    let category: LocalizedStringKey
    let likes: Int
    let isLiked: Bool

    let like: () -> Void
    
    var body: some View {
        
        HStack(spacing: 40) {
            Button(action: {
                like()
            }) {
                Label(title: {
                    Text(String(likes))
                        .font(.subheadline)
                        .foregroundColor(VEXAColors.mainGreen)
                        .fontWeight(.bold)
                }, icon: {
                    Image(systemName: "hand.thumbsup.fill")
                        .foregroundColor(isLiked ? VEXAColors.mainGreen : VEXAColors.grayText)
                })
            }
            
            Spacer()

            (Text("#") + Text(category))
                .modifier(BadgeViewModifier())
        }
    }
}
