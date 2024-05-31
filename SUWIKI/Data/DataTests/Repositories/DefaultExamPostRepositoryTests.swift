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
        repository = DefaultExamPostRepository(apiProvider: mockAPIProvider)
    }

    override func tearDown() {
        repository = nil
        mockAPIProvider = nil
        super.tearDown()
    }

    func testFetchExam() async throws {
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
        mockAPIProvider.setResponse(DTO.FetchExamPostsResponse.self,
                                    response: mockResponse)

        let exam = try await repository.fetch(id: 0, page: 0)

        XCTAssertEqual(exam.posts.count, 1)
        XCTAssertEqual(exam.posts.first?.id, mockExamPost.id)
        XCTAssertEqual(exam.isPurchased, mockResponse.canRead)
        XCTAssertEqual(exam.isWritten, mockResponse.written)
        XCTAssertEqual(exam.isExamPostsExists, mockResponse.examDataExist)
    }
}
