//
//  SwiftUIView.swift
//  
//
//  Created by Leonid Lyadveykin on 13.06.2022.
//

import SwiftUI
import PulseUI

@available(iOS 14.0, *)
public struct DebugView: View {
    @State
    private var isNetworkLoggerShown = false

    public init() {

    }

    public var body: some View {
        NavigationView {
            SwiftUI.List {
                Section {
                    Button("NetworkLogger") {
                        isNetworkLoggerShown = true
                    }
                }
//                Section {
//                    VStack {
//                        Text("Push токен:")
//                        TextField("Нет токена", text: .constant(UserDefaultsConfig.pushToken ?? ""))
//                    }
//                }
            }
            .sheet(isPresented: $isNetworkLoggerShown) {
                MainView(store: VEXALogger.shared.loggerStore)
            }
            .navigationBarTitle("Нарния", displayMode: .inline)
            .padding()
        }
    }
}
