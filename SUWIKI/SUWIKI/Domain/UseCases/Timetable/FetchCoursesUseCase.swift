//
//  FetchCourseUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/13/24.
//

import Foundation

import DIContainer

protocol FetchCoursesUseCase {
    func execute(id: String) -> [Course]?
}

final class DefaultFetchCoursesUseCase: FetchCoursesUseCase {
    @Inject var repository: TimetableRepository

    func execute(id: String) -> [Course]? {
        return repository.fetchCourses(id: id)
    }
}
