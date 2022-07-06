//
//  SwiftUIView.swift
//  
//
//  Created by Leonid Lyadveykin on 07.07.2022.
//

import SwiftUI
import Resources

public struct LogoView: View {
    public init() {

    }
    
    public var body: some View {
        Text("VEXA")
            .font(.largeTitle)
            .foregroundColor(VEXAColors.mainGreen)
            .fontWeight(.bold)
    }
}
