//
//  DefaultNoticeRepositoryTests.swift
//  DataTests
//
//  Created by 한지석 on 5/27/24.
//

import XCTest
@testable import Data
@testable import DIContainer

final class DefaultNoticeRepositoryTests: XCTestCase {

    var mockAPIProvider: MockAPIProvider!
    var repository: DefaultNoticeRepository!

    override func setUp() {
        super.setUp()
        mockAPIProvider = MockAPIProvider()
        repository = DefaultNoticeRepository(apiProvider: mockAPIProvider)
    }

    override func tearDown() {
        repository = nil
        mockAPIProvider = nil
        super.tearDown()
    }

    func testFetchAnnouncements() async throws {
        let mockAnnouncements = [DTO.FetchAnnouncementResponse.FetchAnnouncement(id: 1, title: "Test Title", modifiedDate: "2024-05-28")]
        let mockResponse = DTO.FetchAnnouncementResponse(announcements: mockAnnouncements, statusCode: 200, message: "Success")
        mockAPIProvider.setResponse(DTO.FetchAnnouncementResponse.self,
                                    response: mockResponse)

        // When
        let announcements = try await repository.fetch()

        // Then
        XCTAssertEqual(announcements.count, 1)
        XCTAssertEqual(announcements.first?.title, "Test Title")
    }

    func testFetchDetailAnnouncements() async throws {
        let mockAnnouncement = DTO.FetchDetailAnnouncementResponse.FetchDetailAnnouncement(
            id: 1,
            title: "test",
            modifiedDate: "2022-02-02",
            content: "announcement"
        )
        let mockResponse = DTO.FetchDetailAnnouncementResponse(
            announcement: mockAnnouncement,
            statusCode: 200, 
            message: nil
        )

        let announcement = try await repository.fetchDetail(id: 1)

        XCTAssertEqual(announcement.id, 1)
        XCTAssertEqual(announcement.title, "test")
    }
}
