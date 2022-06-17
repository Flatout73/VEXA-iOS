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
    
    // MARK: - Top View
    
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
    
    // MARK: - About User Information View
    
    var aboutView: some View {
        VStack (spacing: 10) {
            
            HStack(spacing: 10) {
                
                Image("aboutIMG", bundle: .module)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 60, height: 60)
                
                Text("About")
                    .foregroundColor(.black)
                    .font(Font.system(size: 18))
                Spacer()
            }
            
            HStack {
                Text("Email:")
                    .foregroundColor(.gray)
                    .font(Font.system(size: 14))
                    .fontWeight(.bold)
                
                Text(user.email)
                    .foregroundColor(.gray)
                    .font(Font.system(size: 14))
                Spacer()
            }
            
            Divider()
            
            HStack {
                Text("Date of Birth:")
                    .foregroundColor(.gray)
                    .font(Font.system(size: 14))
                    .fontWeight(.bold)
                
                Text(user.dateOfBirth)
                    .foregroundColor(.gray)
                    .font(Font.system(size: 14))
                Spacer()
            }
            
            Divider()
            
            HStack {
                Text("Country:")
                    .foregroundColor(.gray)
                    .font(Font.system(size: 14))
                    .fontWeight(.bold)
                
                Text(user.country)
                    .foregroundColor(.gray)
                    .font(Font.system(size: 14))
                Spacer()
            }
            
            Divider()
            
            HStack {
                Text("Native Language:")
                    .foregroundColor(.gray)
                    .font(Font.system(size: 14))
                    .fontWeight(.bold)
                
                Text(user.nativeLanguage)
                    .foregroundColor(.gray)
                    .font(Font.system(size: 14))
                Spacer()
            }
            
            Divider()
            
            Button(action: {
                
            }) {
                Text("See more")
                    .foregroundColor(.green)
                    .font(.subheadline)
            }
        }
        .background(Color.white)
        .cornerRadius(10)
    }
    
    // MARK: - Horizontal Scroll View with Universities
    
    var universitiesView: some View {
        
        
//        var image: String
//        var title: String
        
        ScrollView(.horizontal, showsIndicators: false) {
            VStack(spacing: 5) {
                
                HStack (spacing: 10) {
                    ForEach(0..<10) { index in
                        VStack {
                            // MARK: - Change for an image
                            Text("University \(index)")
                                .foregroundColor(.white)
                                .font(Font.system(size: 20))
                                .frame(width: 85, height: 85)
                                .background(.green)
                            
                            Text("University Name \(index)")
                                .font(Font.system(size: 10))
                                .foregroundColor(.gray)
                                .bold()
                        }
                    }
                }
            }
            
        }
    }
    
    // MARK: - Horizontal Scroll View with Content

    var studentContentView: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            VStack(spacing: 5) {
                HStack (spacing: 10) {
                    ForEach(user.content, id: \.self) { content in
                        Button(action: {
                            print("Process to content")
                        }) {
                            Image(content, bundle: .module)
                                .resizable()
                                .frame(width: 85, height: 85)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Horizontal Scroll View with Liked Content
    
    var likesView: some View {

        ScrollView(.horizontal, showsIndicators: false) {

            VStack(spacing: 5) {
                HStack (spacing: 10) {
                    ForEach(user.content, id: \.self) { content in
                        Button(action: {
                            print("Process to liked content by student")
                        }) {
                            Image(content, bundle: .module)
                                .resizable()
                                .frame(width: 85, height: 85)
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    var body: some View {
        
        ScrollView (.vertical) {
            VStack {
                
                Group {
                    
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
                    Divider()
                    
                    HStack(spacing: 5) {
                        Text("Universities")
                            .font(Font.system(size: 14))
                            .foregroundColor(.green)
                            .bold()
                            .frame(alignment: .leading)
                        Text("15")
                            .font(Font.system(size: 14))
                            .foregroundColor(.gray)
                            .bold()
                            .frame(alignment: .leading)
                        Spacer()
                    }
                    
                    universitiesView
                    
                    Divider()
                    
                    HStack(spacing: 5) {
                        Text("My Content")
                            .font(Font.system(size: 14))
                            .foregroundColor(.green)
                            .bold()
                            .frame(alignment: .leading)
                        Text("15")
                            .font(Font.system(size: 14))
                            .foregroundColor(.gray)
                            .bold()
                            .frame(alignment: .leading)
                        Spacer()
                    }
                    
                }
                
                Group {
                    
                    Divider()
                    
                    studentContentView
                    
                    Divider()
                    
                    HStack(spacing: 5) {
                        Text("Liked")
                            .font(Font.system(size: 14))
                            .foregroundColor(.green)
                            .bold()
                            .frame(alignment: .leading)
                        Text("15")
                            .font(Font.system(size: 14))
                            .foregroundColor(.gray)
                            .bold()
                            .frame(alignment: .leading)
                        Spacer()
                    }
                    
                    likesView
                    
                    Divider()
                }
                
            }
        }
        .background(Color.clear)
    }
    
}


