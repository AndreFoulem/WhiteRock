//
//  ReviewsRequestManager.swift
//  WhiteRock
//
//  Created by AndreMacBook on 2023-02-27.
//

import Foundation

final class ReviewsRequestManager: ObservableObject {
  
  private let userDefaults = UserDefaults.standard
  private let reviewCountKey = "skyplanet.WhiteRock.reviewCountKey"
  private let lastReviewedVersionKey = "skyplanet.WhiteRock.lastReviewedVersionKey"
  private let limit = 30
  
  @Published private(set) var count: Int
  
  init() {
    self.count = userDefaults.integer(forKey: reviewCountKey)
  }
  
  func canAskForReview() -> Bool {
    let mostRecentReviewed = userDefaults.string(forKey: lastReviewedVersionKey)
    
    guard let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    else { fatalError("expected to find a bundle version in the info dict") }
    
    let hasReachedLimit = userDefaults.integer(forKey: reviewCountKey).isMultiple(of: limit)
    let isNewVersion = currentVersion != mostRecentReviewed
    
    guard hasReachedLimit && isNewVersion else {
      return false
    }
    
    userDefaults.set(currentVersion, forKey: lastReviewedVersionKey)
    
    return true
  }
  
  func increase() {
    count += 1
    userDefaults.set(count, forKey: reviewCountKey)
  }
  
}
