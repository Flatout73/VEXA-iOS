//
//  SwiftUIView.swift
//  
//
//  Created by Егор on 16.06.2022.
//

import SwiftUI
import SharedModels

struct UserProfile: View {
    
    let user: User
    
    var topView: some View {
        
        HStack {
            // MARK: - Need to rewrite the image in AsyncImage
            //                        AsyncImage(url: user.image) { image in
            //                            image
            //                                .resizable()
            //                                .scaledToFill()
            //                        } placeholder: {
            //                            ProgressView()
            //                        }
            //                        .frame(width: 20, height: 20, alignment: .trailing)
            //                        .clipped()
            //                        .cornerRadius(10)
            Image("Jane", bundle: .module)
                .resizable()
                .clipShape(Circle())
                .shadow(radius: 10)
                .overlay(Circle().stroke(Color.white, lineWidth: 5))
                .frame(width: 100, height: 100)
            
            VStack (alignment: .leading, spacing: 10) {
                HStack {
                    Text(user.firstName)
                        .foregroundColor(.black)
                        .font(.subheadline)
                        .fontWeight(.bold)
                    
                    Text(user.secondName)
                        .foregroundColor(.black)
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
                
                Text("Profile status")
                    .foregroundColor(.black)
                    .font(.subheadline)
                
            }
            Spacer()
        }
        .padding()
        .background(Color.white)
    }
    
    var aboutView: some View {
        VStack (spacing: 10) {
            
            HStack(spacing: 10) {
                
                Image("aboutIMG", bundle: .module)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 60, height: 60)
                
                Text("About")
                    .foregroundColor(.black)
                    .font(Font.system(size: 20))
                Spacer()
            }
            
            HStack {
                Text("Email:")
                    .foregroundColor(.gray)
                    .font(Font.system(size: 16))
                    .fontWeight(.bold)
                
                Text(user.email)
                    .foregroundColor(.gray)
                    .font(Font.system(size: 16))
                Spacer()
            }
            
            HStack {
                Text("Date of Birth:")
                    .foregroundColor(.gray)
                    .font(Font.system(size: 16))
                    .fontWeight(.bold)
                
                Text(user.dateOfBirth)
                    .foregroundColor(.gray)
                    .font(Font.system(size: 16))
                Spacer()
            }
            
            HStack {
                Text("Country:")
                    .foregroundColor(.gray)
                    .font(Font.system(size: 16))
                    .fontWeight(.bold)
                
                Text(user.country)
                    .foregroundColor(.gray)
                    .font(Font.system(size: 16))
                Spacer()
            }
            
            HStack {
                Text("Native Language:")
                    .foregroundColor(.gray)
                    .font(Font.system(size: 16))
                    .fontWeight(.bold)
                
                Text(user.nativeLanguage)
                    .foregroundColor(.gray)
                    .font(Font.system(size: 16))
                Spacer()
            }
        }
        .background(Color.white)
        .cornerRadius(10)
    }
    
    var body: some View {
        
        ScrollView (.vertical) {
            VStack {
                
                topView
                
                Button(action: {
                    print("button pressed")
                }) {
                    Text("Message")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50, alignment: .center)
                }
                .background(Color.green)
                .cornerRadius(10)
                .frame(maxWidth: .infinity, maxHeight: 50)
                
                aboutView
                    .padding()
                
                Spacer()
            }
        }
    }
    
}


