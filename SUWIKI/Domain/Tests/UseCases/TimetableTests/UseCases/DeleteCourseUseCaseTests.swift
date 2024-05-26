//
//  DeleteCourseUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/10/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class DeleteCourseUseCaseTests: XCTestCase {
    func testSuccess() {
        let mockReposiotry = MockTimetableRepository()
        DIContainer.shared.register(
            type: TimetableRepository.self,
            mockReposiotry
        )
        let useCase = DefaultDeleteCourseUseCase()
        let isDeleteCourseCalled = true
        mockReposiotry.isDeleteCourseCalled = isDeleteCourseCalled

        let _ = useCase.execute(id: "", courseId: "")

        XCTAssertEqual(isDeleteCourseCalled, mockReposiotry.isDeleteCourseCalled)
    }

    func testFailure() {
        let mockReposiotry = MockTimetableRepository()
        DIContainer.shared.register(
            type: TimetableRepository.self,
            mockReposiotry
        )
        let useCase = DefaultDeleteCourseUseCase()
        let isDeleteCourseCalled = false
        mockReposiotry.isDeleteCourseCalled = isDeleteCourseCalled

        let _ = useCase.execute(id: "", courseId: "")

        XCTAssertEqual(isDeleteCourseCalled, mockReposiotry.isDeleteCourseCalled)
    }
}
