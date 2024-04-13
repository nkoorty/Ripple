//
//  iOSApp.swift
//  iOS
//
//  Created by Christian Grinling on 13/04/2024.
//

import SwiftUI

@main
struct iOSApp: App {
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
