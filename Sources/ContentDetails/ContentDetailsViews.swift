//
//  File.swift
//  
//
//  Created by Егор on 05.07.2022.
//

import SwiftUI
import ComposableArchitecture
import CoreUI
import SharedModels
import Resources
import AVKit


struct ButtonsView: View {
    
    let discovery: DiscoveryModel
    
    var body: some View {
        
        HStack(spacing: 40) {
            Button(action: {
                print("Action button pressed")
                
            }) {
                Image("like", bundle: .module)
                    .resizable()
                    .frame(width: 30, height: 30)
                Text("15")
                    .font(.subheadline)
                    .foregroundColor(VEXAColors.mainGreen)
                    .fontWeight(.bold)
            }
            .buttonStyle(PlainButtonStyle())
            
            Spacer()
            
            Text("#\(discovery.category)")
                .padding(6)
                .background(Color(UIColor.systemGray5))
                .foregroundColor(.secondary)
                .font(.subheadline)
                .cornerRadius(5)
                .lineSpacing(10)
        }
        .padding()
    }
}

struct AmassadorView: View {
    
    let discovery: DiscoveryModel
    
    var body: some View {
        
        Divider()
        
        HStack {
            
            Image("Jane", bundle: .module)
                .resizable()
                .clipShape(Circle())
                .shadow(radius: 10)
                .overlay(Circle().stroke(Color.white, lineWidth: 1))
                .frame(width: 60, height: 60)
            VStack {
                HStack {
                    Text(discovery.ambassador)
                        .font(.subheadline)
                        .foregroundColor(VEXAColors.mainGreen)
                        .fontWeight(.bold)
                    
                    Text("Ambassador")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Button(action: {
                    print("University Button Pressed")
                    
                }) {
                    Text(discovery.universityName)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            Button(action: {
                print("message button pressed")
                
            }) {
                Image("Message", bundle: .module)
            }
            .buttonStyle(PlainButtonStyle())
            
        }

        Divider()
    }
}

struct DescriptionView: View {
    
    @State
    private var showingSheet = false
    
    let discovery: DiscoveryModel
    
    var body: some View {
        VStack {
            Group {
                Button(action: {
                    showingSheet.toggle()
                }) {
                    Text(showingSheet ? "Hide" : "See more")
                        .foregroundColor(VEXAColors.mainGreen)
                        .font(.subheadline)
                        .padding()
                }
                if showingSheet {
                    Text(discovery.desctription)
                        .font(.body)
                        .foregroundColor(.gray)
                        .padding()
                }
            }
        }
    }
}
