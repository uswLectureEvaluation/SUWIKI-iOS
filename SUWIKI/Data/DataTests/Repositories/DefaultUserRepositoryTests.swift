//
//  DefaultUserRepositoryTests.swift
//  DataTests
//
//  Created by 한지석 on 6/19/24.
//

import XCTest
@testable import Data

final class DefaultUserRepositoryTests: XCTestCase {
  var mockAPIProvider: MockAPIProvider!
  var repository: DefaultUserRepository!

  override func setUp() {
    super.setUp()
    mockAPIProvider = MockAPIProvider()
    repository = DefaultUserRepository(
      apiProvider: mockAPIProvider
    )
  }

  override func tearDown() {
    repository = nil
    mockAPIProvider = nil
    super.tearDown()
  }

  func testLogin() async throws {
    let mockResponse = DTO.TokenResponse(
      AccessToken: "",
      RefreshToken: ""
    )
    mockAPIProvider.setResponse(
      DTO.TokenResponse.self,
      response: mockResponse
    )
    
    let success = try await repository.login(
      id: "",
      password: ""
    )

    XCTAssertEqual(
      success,
      true
    )
  }

  func testCheckDuplicatedId() async throws {
    let mockResponse = DTO.CheckDuplicatedIdResponse(
      overlap: true
    )
    mockAPIProvider.setResponse(
      DTO.CheckDuplicatedIdResponse.self,
      response: mockResponse
    )
    
    let duplicated = try await repository.checkDuplicatedId(
      id: ""
    )
    
    XCTAssertEqual(
      duplicated,
      true
    )
  }
  
  func testCheckDuplicatedEmail() async throws {
    let mockResponse = DTO.CheckDuplicatedEmailResponse(
      overlap: true
    )
    mockAPIProvider.setResponse(
      DTO.CheckDuplicatedEmailResponse.self,
      response: mockResponse
    )
    
    let duplicated = try await repository.checkDuplicatedEmail(
      email: ""
    )
    
    XCTAssertEqual(
      duplicated,
      true
    )
  }

  func testGetUserInfo() async throws {
    let id = "iostest"
    let email = "sozohoy@gmail.com"
    let point = 2086

    let mockResponse = DTO.UserInfoResponse(
      loginId: id,
      email: email,
      point: point,
      writtenEvaluation: 0,
      writtenExam: 0,
      viewExam: 0
    )
    mockAPIProvider.setResponse(
      DTO.UserInfoResponse.self,
      response: mockResponse
    )

    let userInfo = try await repository.userInfo()

    XCTAssertEqual(
      userInfo.id,
      id
    )
    XCTAssertEqual(
      userInfo.email,
      email
    )
    XCTAssertEqual(
      userInfo.point,
      point
    )
  }

}
