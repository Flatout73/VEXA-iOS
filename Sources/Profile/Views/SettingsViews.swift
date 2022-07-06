//
//  File.swift
//  
//
//  Created by Егор on 27.06.2022.
//

import SwiftUI
import SharedModels
import Resources

struct TopView: View {
    
    let user: StudentModel
    
    var body: some View {
        VStack {
            Image("Jane", bundle: .module)
                .resizable()
                .clipShape(Circle())
                .shadow(radius: 10)
                .overlay(Circle().stroke(Color.white, lineWidth: 5))
                .frame(width: 100, height: 100)
            
            Text("Tap to change photo")
                .foregroundColor(.white)
                .font(.title3)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
        .padding()
        .background(VEXAColors.mainGreen)
    }
}


struct GeneralInfoView: View {
    
    let user: StudentModel
    
    @State private var userFirstName: String = ""
    @State private var userSecondName: String = ""
    @State private var email: String = ""
    @State private var dateOfBirthhday: String = ""
    @State private var nativeLanguage: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("First Name")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .fontWeight(.bold)
            
                TextField("User Name", text: $userFirstName)
                    .underlineTextField()
            Divider()
            
                Text("Second Name")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .fontWeight(.bold)
            
                TextField("Second Name", text: $userSecondName)
                    .underlineTextField()
            Divider()
            
            Text("Email")
                .foregroundColor(.gray)
                .font(.subheadline)
                .fontWeight(.bold)
        
            TextField("Email", text: $email)
                .underlineTextField()
            Divider()
                
            }
            
            Text("Date of Birth")
                .foregroundColor(.gray)
                .font(.subheadline)
                .fontWeight(.bold)
        
            TextField("Date of Birthday", text: $dateOfBirthhday)
                .underlineTextField()
            Divider()
            
            Text("Native Language")
                .foregroundColor(.gray)
                .font(.subheadline)
                .fontWeight(.bold)
        
            TextField("Native Language", text: $nativeLanguage)
                .underlineTextField()
            Divider()
            
        }
        
        VStack(alignment: .center) {
            Button(action: {
                print("Save button is tapped")
            }) {
                Text("Save your settings")
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 300, height: 20)
                    .padding()
                    .background(VEXAColors.mainGreen)
                    .cornerRadius(10)
                    
                
            }
        }
    }
    
    
}


extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(
                Rectangle().frame(height: 2).padding(.top, 35)
            )
            .foregroundColor(VEXAColors.mainGreen)
            .padding(10)
    }
}
