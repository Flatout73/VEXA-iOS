//
//  SwiftUIView.swift
//  
//
//  Created by Егор on 16.06.2022.
//

import SwiftUI
import SharedModels
import Resources

struct UserProfileView: View {
    
    let user: StudentModel
    
    @State private var showingSheet = false
    
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
                    .font(.title3)
                Spacer()
            }
            
            HStack {
                Text("Email:")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .fontWeight(.bold)
                
                Text(user.email)
                    .foregroundColor(.gray)
                    .font(.subheadline)
                Spacer()
            }
            
            Divider()
            
            HStack {
                Text("Date of Birth:")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .fontWeight(.bold)
                
                Text(user.dateOfBirth, formatter: DateFormatter())
                    .foregroundColor(.gray)
                    .font(.subheadline)
                Spacer()
            }
            
            Divider()
            
            HStack {
                Text("Country:")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .fontWeight(.bold)
                
                Text(user.country)
                    .foregroundColor(.gray)
                    .font(.subheadline)
                Spacer()
            }
            
            Divider()
            
            HStack {
                Text("Native Language:")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .fontWeight(.bold)
                
                Text(user.nativeLanguage)
                    .foregroundColor(.gray)
                    .font(.subheadline)
                Spacer()
            }
            
            Divider()
            
            Group {
                Button(action: {
                    showingSheet.toggle()
                }) {
                    Text(showingSheet ? "Hide" : "See more")
                        .foregroundColor(VEXAColors.mainGreen)
                        .font(.subheadline)
                }
                if showingSheet {
                    textView
                }
            }
        }
        .padding()
        .background(VEXAColors.formBackground)
        .cornerRadius(10)
    }
    
    // MARK: - Extra Text Fields for view
    
    var textView: some View {
     
        VStack {
            HStack {
                Text("Extra Text:")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .fontWeight(.bold)
                
                Text("User Info")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                Spacer()
            }
            
            Divider()
            
            HStack {
                Text("Extra Text:")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .fontWeight(.bold)
                
                Text("User Info")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                Spacer()
            }
        }
        
        
    }
    
    // MARK: - Horizontal Scroll View with Universities
    
    var universitiesView: some View {
        
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
                                .background(VEXAColors.mainGreen)
                            
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
    
    // MARK: - Horizontal Scroll View with Liked Content
    
//    var likesView: some View {
//
//        ScrollView(.horizontal, showsIndicators: false) {
//
//            VStack(spacing: 5) {
//                HStack (spacing: 10) {
//                    ForEach(user.content, id: \.self) { content in
//                        Button(action: {
//                            print("Process to liked content by student")
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
    
    @ViewBuilder
    var body: some View {
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
                .background(VEXAColors.mainGreen)
                .cornerRadius(10)
                .frame(maxWidth: .infinity, maxHeight: 50)
                
                aboutView
                
                Spacer()
                Divider()
                
                HStack(spacing: 5) {
                    Text("Universities")
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
                
                universitiesView
                
            }
            
            Group {
                
                Divider()
                
                HStack(spacing: 5) {
                    Text("Liked")
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
                
               // likesView
                
                Divider()
            }
            
        }
    }
    
}


