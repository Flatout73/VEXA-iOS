//
//  SwiftUIView.swift
//  
//
//  Created by Leonid Lyadveykin on 19.07.2022.
//

import SwiftUI

public struct BadgeViewModifier: ViewModifier {

    public init() {
        
    }

    public func body(content: Content) -> some View {
        content
        .padding(6)
        .background(Color(UIColor.systemGray5))
        .foregroundColor(.secondary)
        .font(.subheadline)
        .cornerRadius(5)
        .lineSpacing(10)
    }
}

