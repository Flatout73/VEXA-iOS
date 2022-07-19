//
//  SwiftUIView.swift
//  
//
//  Created by Leonid Lyadveykin on 19.07.2022.
//

import SwiftUI

public struct BadgeView: View {
    public let title: String

    public init(title: String) {
        self.title = title
    }

    public var body: some View {
        Text(title)
            .padding(6)
            .background(Color(UIColor.systemGray5))
            .foregroundColor(.secondary)
            .font(.subheadline)
            .cornerRadius(5)
            .lineSpacing(10)
    }
}

