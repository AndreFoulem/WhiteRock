//
//  ReviewsRequestManager.swift
//  WhiteRock
//
//  Created by AndreMacBook on 2023-02-27.
//

import Foundation

final class ReviewsRequestManager: ObservableObject {
  
//  private let userDefaults = UserDefaults.standard
  private let userDefaults: UserDefaults
  private let lastReviewedVersionKey = "skyplanet.WhiteRock.lastReviewedVersionKey"
  private(set) var reviewLink = URL(string: "https://apps.apple.com/[id]?action=write-review")
  
  let limit = 30
  let reviewCountKey = "skyplanet.WhiteRock.reviewCountKey"

  
  @Published private(set) var count: Int
  
  init(userDefaults: UserDefaults = UserDefaults.standard) {
    self.userDefaults = userDefaults
    self.count = userDefaults.integer(forKey: reviewCountKey)
  }
  
  func canAskForReview(
    lastReviewedVersion: String? = nil,
    currentVersion: String? = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
  ) -> Bool {

    let mostRecentReviewed = lastReviewedVersion ?? userDefaults.string(forKey: lastReviewedVersionKey)
    
    guard let currentVersion = currentVersion
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
