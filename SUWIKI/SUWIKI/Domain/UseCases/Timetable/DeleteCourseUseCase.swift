//
//  DeleteCourseUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/14/24.
//

import Foundation

protocol DeleteCourseUseCase {
    func execute(id: String, courseId: String)
}

final class DefaultDeleteCourseUseCase: DeleteCourseUseCase {
    @Inject var repository: TimetableRepository

    func execute(id: String, courseId: String) {
        repository.deleteCourse(id: id, courseId: courseId)
    }
}
