//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 06.07.2022.
//

import SwiftUI
import Resources

public struct SecondaryButtonStyle: ButtonStyle {

    public init() {

    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(VEXAColors.red)
            .opacity(configuration.isPressed ? 0.7 : 1.0)
    }
}
