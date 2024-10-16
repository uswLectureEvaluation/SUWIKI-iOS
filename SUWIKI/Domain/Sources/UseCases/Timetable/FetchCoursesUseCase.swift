//
//  FetchCourseUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/13/24.
//

import Foundation

import DIContainer

public protocol FetchCoursesUseCase {
  func execute(
    id: String
  ) -> [TimetableCourse]?
}

public final class DefaultFetchCoursesUseCase: FetchCoursesUseCase {
  @Inject private var repository: TimetableRepository
  
  public init() { }
  
  public func execute(
    id: String
  ) -> [TimetableCourse]? {
    let result = repository.fetchCourses(id: id)
    switch result {
    case .success(let timetableCourse):
      return timetableCourse
    case .failure:
      return nil
    }
  }
}
