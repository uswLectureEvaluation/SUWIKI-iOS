//
//  FetchFirebaseCourseUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/14/24.
//

import Foundation

import DIContainer

public protocol FetchFirebaseCourseUseCase {
  func execute(
    major: String
  ) -> [FetchCourse]
}

public final class DefaultFetchFirebaseCourseUseCase: FetchFirebaseCourseUseCase {
  @Inject private var repository: TimetableRepository
  
  public init() { }
  
  public func execute(
    major: String
  ) -> [FetchCourse] {
    let result = repository.fetchFirebaseCourse(major: major)
    switch result {
    case .success(let fetchCourse):
      return fetchCourse
    case .failure:
      return []
    }
  }
}
