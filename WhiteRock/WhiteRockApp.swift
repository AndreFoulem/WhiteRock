//
//  WhiteRockApp.swift
//  WhiteRock
//
//  Created by AndreMacBook on 2023-02-21.
//

import SwiftUI

@main
struct WhiteRockApp: App {
  
  @StateObject private var reviewsManager = ReviewsRequestManager()
  
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(reviewsManager)
        }
    }
}
