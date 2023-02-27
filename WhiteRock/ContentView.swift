//
//  ContentView.swift
//  WhiteRock
//
//  Created by AndreMacBook on 2023-02-21.
//

import SwiftUI
import StoreKit

struct ContentView: View {
  
  @Environment(\.requestReview) var requestReview: RequestReviewAction
  
  var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
          Rectangle()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
