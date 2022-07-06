//
//  File.swift
//  
//
//  Created by Leonid Lyadveykin on 07.07.2022.
//

import Foundation
import SwiftUI
import Resources

public struct VEXATextFieldStyle: TextFieldStyle {
    public init() {

    }
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .padding(16)
                .background(VEXAColors.itemBackground)
                .cornerRadius(10)
        }
}
