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
    repository = DefaultEvaluationPostRepository(
      apiProvider: mockAPIProvider
    )
  }
  
  override func tearDown() {
    repository = nil
    mockAPIProvider = nil
    super.tearDown()
  }
  
  func testFetchEvaluationPosts() async throws {
    let mockEvaluationPost = DTO.EvaluationPostResponse(
      id: 0,
      selectedSemester: "2022-2",
      totalAvg: 0,
      satisfaction: 0,
      learning: 0,
      honey: 0,
      team: 0,
      difficulty: 0,
      homework: 0,
      content: "evaluationTest"
    )
    let mockResponse = DTO.FetchEvaluationPostsResponse(
      posts: [mockEvaluationPost],
      written: true
    )
    mockAPIProvider.setResponse(
      DTO.FetchEvaluationPostsResponse.self,
      response: mockResponse
    )
    
    let evalaution = try await repository.fetch(
      lectureId: 0,
      page: 0
    )
    XCTAssertEqual(
      evalaution.posts.count,
      1
    )
    XCTAssertEqual(
      evalaution.posts.first?.id,
      mockEvaluationPost.id
    )
    XCTAssertEqual(
      evalaution.written,
      true
    )
  }
  
  func testFetchUserPosts() async throws {
    let mockEvaluationPost = DTO.FetchUserEvaluationPostsResponse.UserEvaluationPostResponse(
      id: 1,
      lectureName: "",
      professor: "",
      majorType: "",
      selectedSemester: "",
      semesterList: "",
      totalAvg: 0,
      satisfaction: 0,
      learning: 0,
      honey: 0,
      team: 0,
      difficulty: 0,
      homework: 0,
      content: "evaluationTest"
    )
    let mockResponse = DTO.FetchUserEvaluationPostsResponse(
      posts: [mockEvaluationPost],
      statusCode: 200,
      message: "success"
    )
    mockAPIProvider.setResponse(
      DTO.FetchUserEvaluationPostsResponse.self,
      response: mockResponse
    )
    
    let userPosts = try await repository.fetchUserPosts()
    
    XCTAssertEqual(
      userPosts.count,
      1
    )
    XCTAssertEqual(
      userPosts.first?.id,
      1
    )
    XCTAssertEqual(
      userPosts.first?.content,
      "evaluationTest"
    )
  }
}
