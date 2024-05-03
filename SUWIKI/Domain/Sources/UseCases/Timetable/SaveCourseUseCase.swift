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
        repository.saveCourse(
            id: id,
            course: course
        )
    }
}
