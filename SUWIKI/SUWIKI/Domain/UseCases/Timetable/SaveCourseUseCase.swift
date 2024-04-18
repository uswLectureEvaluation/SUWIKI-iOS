//
//  SaveCourseUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/14/24.
//

import Foundation

import DIContainer

protocol SaveCourseUseCase {
    func execute(
        id: String,
        course: TimetableCourse
    )
}

final class DefaultSaveCourseUseCase: SaveCourseUseCase {
    @Inject var repository: TimetableRepository

    func execute(id: String, course: TimetableCourse) {
        repository.saveCourse(id: id, course: course)
    }
}
