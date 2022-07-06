//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 06.07.2022.
//

import SwiftUI
import Resources

public struct SecondaryButtonStyle: ButtonStyle {
    let color: Color

    public init(color: Color = VEXAColors.mainGreen) {
        self.color = color
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.callout)
            .foregroundColor(color)
            .opacity(configuration.isPressed ? 0.7 : 1.0)
    }
}
