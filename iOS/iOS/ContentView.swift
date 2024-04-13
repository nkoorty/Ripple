//
//  ContentView.swift
//  iOS
//
//  Created by Christian Grinling on 13/04/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

struct Payment {
    var userPrivateKey: String
    var itemAmount: Double
    var item: String
    var itemVendorPublicKey: String
    var duration: Int
    var interval: Int
}

/*
interval = daily, weekly, monthly
duration(in days) = 30
 */

