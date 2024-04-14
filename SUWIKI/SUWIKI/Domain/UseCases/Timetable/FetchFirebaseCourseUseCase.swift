//
//  FetchFirebaseCourseUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/14/24.
//

import Foundation

protocol FetchFirebaseCourseUseCase {
    func execute(major: String) -> [FirebaseCourse]
}

final class DefaultFetchFirebaseCourseUseCase: FetchFirebaseCourseUseCase {
    @Inject var repository: TimetableRepository

    func execute(major: String) -> [FirebaseCourse] {
        return repository.fetchFirebaseCourse(major: major)
    }
}
