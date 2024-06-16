//
//  DefaultExamPostRepositoryTests.swift
//  DataTests
//
//  Created by 한지석 on 5/31/24.
//

import XCTest
@testable import Data

final class DefaultExamPostRepositoryTests: XCTestCase {
  
  var mockAPIProvider: MockAPIProvider!
  var repository: DefaultExamPostRepository!
  
  override func setUp() {
    super.setUp()
    mockAPIProvider = MockAPIProvider()
    repository = DefaultExamPostRepository(
      apiProvider: mockAPIProvider
    )
  }
  
  override func tearDown() {
    repository = nil
    mockAPIProvider = nil
    super.tearDown()
  }
  
  func testFetchExamPosts() async throws {
    let mockExamPost = DTO.ExamPostResponse(
      id: 0,
      selectedSemester: "",
      examInfo: "",
      examType: "",
      examDifficulty: "",
      content: ""
    )
    let mockResponse = DTO.FetchExamPostsResponse(
      posts: [mockExamPost],
      canRead: true,
      written: true,
      examDataExist: true
    )
    mockAPIProvider.setResponse(
      DTO.FetchExamPostsResponse.self,
      response: mockResponse
    )
    
    let exam = try await repository.fetch(
      id: 0,
      page: 0
    )
    
    XCTAssertEqual(
      exam.posts.count,
      1
    )
    XCTAssertEqual(
      exam.posts.first?.id,
      mockExamPost.id
    )
    XCTAssertEqual(
      exam.isPurchased,
      mockResponse.canRead
    )
    XCTAssertEqual(
      exam.isWritten,
      mockResponse.written
    )
    XCTAssertEqual(
      exam.isExamPostsExists,
      mockResponse.examDataExist
    )
  }
  
  func testFetchUserPosts() async throws {
    let mockUserExamPost = DTO
      .FetchUserExamPostsResponse
      .UserExamPostResponse(
        id: 0,
        lectureName: "test name",
        professor: "",
        majorType: "",
        selectedSemester: "",
        semesterList: "",
        examType: "",
        examInfo: "",
        examDifficulty: "",
        content: ""
      )
    let mockResponse = DTO.FetchUserExamPostsResponse(
      posts: [mockUserExamPost],
      statusCode: 200,
      message: "success"
    )
    
    mockAPIProvider.setResponse(
      DTO.FetchUserExamPostsResponse.self,
      response: mockResponse
    )
    
    let userPosts = try await repository.fetchUserPosts()
    
    XCTAssertEqual(
      userPosts.count,
      1
    )
    XCTAssertEqual(
      userPosts.first?.id,
      mockUserExamPost.id
    )
    XCTAssertEqual(
      userPosts.first?.name,
      "test name"
    )
  }
  
  func testFetchPurchasedExamPosts() async throws {
    let mockPurchasedExamPost = DTO
      .FetchPurchasedExamPostsResponse
      .PurchasedExamPosts(
        id: 1,
        professor: "",
        lectureName: "",
        majorType: "",
        createDate: ""
      )
    let mockResponse = DTO.FetchPurchasedExamPostsResponse(
      posts: [mockPurchasedExamPost],
      statusCode: 200,
      message: "success"
    )
    mockAPIProvider.setResponse(
      DTO.FetchPurchasedExamPostsResponse.self,
      response: mockResponse
    )
    
    let purchasedPost = try await repository.fetchPurchasedExamPosts()
    
    XCTAssertEqual(
      purchasedPost.count,
      1
    )
    XCTAssertEqual(
      purchasedPost.first?.id,
      1
    )
  }
}
