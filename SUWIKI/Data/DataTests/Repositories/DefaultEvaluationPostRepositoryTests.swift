//
//  DefaultEvaluationRepositoryTests.swift
//  DataTests
//
//  Created by 한지석 on 6/17/24.
//

import XCTest
@testable import Data

final class DefaultEvaluationPostRepositoryTests: XCTestCase {
  
  var mockAPIProvider: MockAPIProvider!
  var repository: DefaultEvaluationPostRepository!

  override func setUp() {
    super.setUp()
    mockAPIProvider = MockAPIProvider()
    repository = DefaultExamPostRepository(apiProvider: mockAPIProvider)
  }
  
  override func tearDown() {
    repository = nil
    mockAPIProvider = nil
    super.tearDown()
  }
}
