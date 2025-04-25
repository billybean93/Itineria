//
//  a2_S3909873_S3915181App.swift
//  a2-S3909873-S3915181
//
//  Created by Daniel La on 23/9/2024.
//

import SwiftUI
import SwiftData

@main
struct a2_S3909873_S3915181App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ItineraryModel.self)
    }
}
