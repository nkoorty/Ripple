//
//  RippleXApp.swift
//  RippleX
//
//  Created by Artemiy Malyshau on 13/04/2024.
//

import SwiftUI

@main
struct RippleXApp: App {
    @AppStorage("signin") var isSignedIn = false

    var body: some Scene {
        WindowGroup {
            LoginView()
                .preferredColorScheme(.dark)
                .fullScreenCover(isPresented: $isSignedIn, content: {
                    TabBarView()
                        .preferredColorScheme(.dark)
                })
        }
    }
}
