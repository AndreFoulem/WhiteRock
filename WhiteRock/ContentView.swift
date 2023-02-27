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
  @State private var counter: Int = 0
  
  var body: some View {
        VStack {
           Text("\(counter)")
            .font(.system(.largeTitle, design: .rounded, weight: .bold))
          Button {
            counter += 1
            if counter.isMultiple(of: 5) {
                              requestReview()
            }
          } label: {
            Text("Increase")
          }
          .buttonStyle(.borderedProminent)
          .controlSize(.large)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
