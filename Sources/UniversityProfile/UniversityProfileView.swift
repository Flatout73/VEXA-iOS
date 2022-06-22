//
//  SwiftUIView.swift
//  
//
//  Created by Егор on 20.06.2022.
//

import SwiftUI
import ComposableArchitecture
import CoreUI
import Resources
import SharedModels

public struct UniversityProfileView: View {
    
    let store: Store<UniversityState, UniversityAction>

    public init(store: Store<UniversityState, UniversityAction>) {
        self.store = store
    }
    
    
    
    
    public var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

