//
//  File.swift
//  
//
//  Created by Егор on 27.06.2022.
//

import SwiftUI
import SharedModels
import Resources

struct UserSettingsView: View {
    
    let user: User
    
    @ViewBuilder
    var body: some View {
        
        ScrollView (.vertical) {
            
            TopView(user: user)
            Divider()
            GeneralInfoView(user: user)
            
        }
    }
    
}
