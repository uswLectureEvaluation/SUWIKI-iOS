//
//  DefaultLectureRepositoryTests.swift
//  DataTests
//
//  Created by 한지석 on 6/17/24.
//

import XCTest
@testable import Data

final class DefaultLectureRepositoryTests: XCTestCase {
  
  var mockAPIProvider: MockAPIProvider!
  var repository: DefaultLectureRepository!

  override func setUp() {
    super.setUp()
    mockAPIProvider = MockAPIProvider()
    repository = DefaultLectureRepository(apiProvider: mockAPIProvider)
  }

  override func tearDown() {
    repository = nil
    mockAPIProvider = nil
    super.tearDown()
  }

}
