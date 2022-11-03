//
//  FirestoreHypixelApp.swift
//  FirestoreHypixel
//
//  Created by Tom Miller on 31/07/2022.
//

import SwiftUI
import Firebase
@main
struct FirestoreHypixelApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
