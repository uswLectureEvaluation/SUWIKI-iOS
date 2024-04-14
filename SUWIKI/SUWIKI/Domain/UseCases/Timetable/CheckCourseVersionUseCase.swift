//
//  CheckCourseVersionUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/14/24.
//

import Foundation

protocol CheckCourseVersionUseCase {
    func execute() async throws
}

final class DefaultCheckCourseVersionUseCase: CheckCourseVersionUseCase {
    @Inject var repository: TimetableRepository

    func execute() async throws {
        try await repository.checkCourseVersion()
    }
}
