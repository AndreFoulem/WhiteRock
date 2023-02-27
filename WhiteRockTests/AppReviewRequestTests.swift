//
//  WhiteRockTests.swift
//  WhiteRockTests
//
//  Created by AndreMacBook on 2023-02-27.
//

import XCTest
@testable import WhiteRock

final class AppReviewRequestTests: XCTestCase {

  private var userDefaults: UserDefaults!
  private var sut: ReviewsRequestManager!
  
  override func setUp() {
    userDefaults = UserDefaults(suiteName: #file)
    sut = ReviewsRequestManager(userDefaults: userDefaults)
  }
  
  override func tearDown() {
    userDefaults.removePersistentDomain(forName: #file)
    userDefaults = nil
    sut = nil
  }
  
  func increase() {
    for _ in 0..<sut.limit {
      sut.increase()
    }
  }

  func testCount_IsIncreased_WhenCalled() {
    XCTAssertEqual(sut.count, 0,"The initial value should be 0")
    sut.increase()
    XCTAssertEqual(sut.count,1,"The new value should be one")
    XCTAssertEqual(userDefaults.integer(forKey: sut.reviewCountKey), 1, "the value for userDefaults should be one")
  }
  
  func testApp_IsValidForRequest_OnFreshLaunch() {
    for _ in 0..<sut.limit {
      sut.increase()
    }
    XCTAssertTrue(sut.canAskForReview(),
                  "The user has hit limit the limit\(sut.limit)")
  }
  func testApp_IsInvalidForRequest_OnFreshLaunch() {
    for _ in 0..<sut.limit - 1 {
      sut.increase()
    }
    XCTAssertFalse(sut.canAskForReview(),
                  "The user has not hit the limit the limit\(sut.limit)")
  }
  func testApp_IsInvalidForRequest_AfterLimitReached() {
      increase()
      XCTAssertTrue(sut.canAskForReview(),
                    "The user has hit limit the limit\(sut.limit)")
      increase()
      XCTAssertFalse(sut.canAskForReview(),
                     "The user has not hit the limit the limit\(sut.limit)")
  }
  func testApp_IsInvalidForRequest_ForNewVersion() {
    let oldVersion = "1.0"
    let newVersion = "1.1"
    
    increase()
    
    let canAskForReview = sut.canAskForReview(lastReviewedVersion: nil, currentVersion: oldVersion)
    XCTAssertTrue(sut.canAskForReview(),
                  "The user has hit limit the limit\(sut.limit)")
    
    increase()
    
    let canAskForReviewNewVersion = sut.canAskForReview(lastReviewedVersion: oldVersion, currentVersion: newVersion)
    XCTAssertTrue(sut.canAskForReview(),
                  "The user has hit limit the limit\(sut.limit)")
    increase()
    let canAskForReviewSameVersion = sut.canAskForReview(lastReviewedVersion: newVersion, currentVersion: newVersion)
    
    XCTAssertFalse(sut.canAskForReview(),
                  "The user has hit limit the limit\(sut.limit)")
  }
  func testApp_IsValidForRequest_ForNewVersion() {
    
  }

}
