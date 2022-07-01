//
//  File.swift
//  
//
//  Created by Егор on 30.06.2022.
//

import SwiftUI
import Resources
import SharedModels

public struct AmbassadorPageView: View {
    
    public init(ambassador: String, size: CGSize) {
        self.ambassador = ambassador
        self.size = size
    }
    
    let ambassador: String
    let size: CGSize
    
    @ViewBuilder
    public var body: some View {
        VStack(alignment: .leading) {
            HStack() {
                Image("Jane", bundle: .module)
                    .resizable()
                    .frame(width: 75, height: 75)
                    .cornerRadius(10)
                VStack(alignment: .leading) {
                    Text("Jane Jhonson")
                        .font(.title2)
                        .foregroundColor(.black)
                        .bold()
                    Text("Harper College Amassador")
                        .font(.subheadline)
                        .foregroundColor(.black)
                }
                Spacer()
                Button(action: {
                    print("message button pressed")
                    
                }) {
                    Image("Message", bundle: .module)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(VEXAColors.formBackground)
    }
    
    
}

