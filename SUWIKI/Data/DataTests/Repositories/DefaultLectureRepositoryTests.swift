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
    repository = DefaultLectureRepository(
      apiProvider: mockAPIProvider
    )
  }

  override func tearDown() {
    repository = nil
    mockAPIProvider = nil
    super.tearDown()
  }

  func testFetchLectures() async throws {
    let id = 2086
    let major = "정보보호"

    let mockLectures = [
      DTO.LectureResponse(
        id: id,
        semesterList: "",
        professor: "",
        majorType: major,
        lectureType: "",
        lectureName: "",
        lectureTotalAvg: 0,
        lectureSatisfactionAvg: 0,
        lectureHoneyAvg: 0,
        lectureLearningAvg: 0
      )
    ]
    let mockResponse = DTO.AllLectureResponse(
      lecture: mockLectures,
      count: 1
    )
    mockAPIProvider.setResponse(
      DTO.AllLectureResponse.self,
      response: mockResponse
    )

    let lectures = try await repository.fetch(
      option: .modifiedDate,
      page: 0,
      major: major
    )

    XCTAssertEqual(
      lectures.count,
      mockLectures.count
    )
    XCTAssertEqual(
      lectures.first?.id,
      id
    )
    XCTAssertEqual(
      lectures.first?.major,
      major
    )
  }

  func testSearchLectures() async throws {
    let id = 2086
    let searchText = "자바"
    let major = "정보보호"

    let mockLectures = [
      DTO.LectureResponse(
        id: id,
        semesterList: "",
        professor: "",
        majorType: major,
        lectureType: "",
        lectureName: searchText,
        lectureTotalAvg: 0,
        lectureSatisfactionAvg: 0,
        lectureHoneyAvg: 0,
        lectureLearningAvg: 0
      )
    ]
    let mockResponse = DTO.AllLectureResponse(
      lecture: mockLectures,
      count: mockLectures.count
    )
    mockAPIProvider.setResponse(
      DTO.AllLectureResponse.self,
      response: mockResponse
    )

    let lectures = try await repository.search(
      searchText: searchText,
      option: .modifiedDate,
      page: 0,
      major: major
    )

    XCTAssertEqual(
      lectures.count,
      mockLectures.count
    )
    XCTAssertEqual(
      lectures.first?.id,
      id
    )
    XCTAssertEqual(
      lectures.first?.name,
      searchText
    )
    XCTAssertEqual(
      lectures.first?.major,
      major
    )
  }

  func testFetchDetailLecture() async throws {
    let id = 2086
    let major = "정보보호"
    let lectureName = "자바"

    let mockDetailLecture = DTO.DetailLectureResponse(
      id: id,
      semesterList: "",
      professor: "",
      majorType: major,
      lectureType: "",
      lectureName: lectureName,
      lectureTotalAvg: 0,
      lectureSatisfactionAvg: 0,
      lectureHoneyAvg: 0,
      lectureLearningAvg: 0,
      lectureTeamAvg: 0,
      lectureDifficultyAvg: 0,
      lectureHomeworkAvg: 0
    )
    let mockResponse = DTO.DecodingDetailLectureResponse(
      statusCode: 200,
      message: "",
      detailLecture: mockDetailLecture
    )
    mockAPIProvider.setResponse(
      DTO.DecodingDetailLectureResponse.self,
      response: mockResponse
    )

    let lecture = try await repository.fetchDetail(
      id: id
    )
    
    XCTAssertEqual(
      lecture.id,
      id
    )
    XCTAssertEqual(
      lecture.name,
      lectureName
    )
    XCTAssertEqual(
      lecture.major,
      major
    )
  }

}
