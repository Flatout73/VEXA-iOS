//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 06.07.2022.
//

import SwiftUI
import Resources

public struct VEXAButtonStyle: ButtonStyle {
    
    public init() {

    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
            .background(VEXAColors.mainGreen)
            .cornerRadius(10)
            .opacity(configuration.isPressed ? 0.7 : 1.0)
    }
}
