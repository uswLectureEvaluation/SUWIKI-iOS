//
//  DeleteCourseUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/14/24.
//

import Foundation

import DIContainer

public protocol DeleteCourseUseCase {
    func execute(
        id: String,
        courseId: String
    )
}

public final class DefaultDeleteCourseUseCase: DeleteCourseUseCase {
    @Inject private var repository: TimetableRepository

    public init() { }

    public func execute(
        id: String,
        courseId: String
    ) {
        repository.deleteCourse(
            id: id,
            courseId: courseId
        )
    }
}
