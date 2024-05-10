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
        let result = repository.deleteCourse(
            id: id,
            courseId: courseId
        )
        switch result {
        case .success:
            break
        case .failure(let failure):
            dump(failure)
        }
    }
}
