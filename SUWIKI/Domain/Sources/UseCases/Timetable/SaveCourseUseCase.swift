//
//  SaveCourseUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/14/24.
//

import Foundation

import DIContainer

public protocol SaveCourseUseCase {
    func execute(
        id: String,
        course: TimetableCourse
    )
}

public final class DefaultSaveCourseUseCase: SaveCourseUseCase {
    @Inject private var repository: TimetableRepository

    public init() { }

    public func execute(
        id: String,
        course: TimetableCourse
    ) {
        let result = repository.saveCourse(
            id: id,
            course: course
        )
        switch result {
        case .success:
            break
        case .failure(let failure):
            dump(failure)
        }
    }
}
