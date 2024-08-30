//
//  FetchCourseCountUseCase.swift
//  Domain
//
//  Created by 한지석 on 8/30/24.
//

import Foundation

import DIContainer

public protocol FetchCourseCountUseCase {
  func execute(major: String)-> Int
}

public final class DefaultFetchCourseCountUseCase: FetchCourseCountUseCase {
  @Inject var repository: TimetableRepository

  public init() { }

  public func execute(major: String) -> Int {
    let result = repository.fetchCourseCount(major: major)
    switch result {
    case .success(let count):
      return count
    case .failure(let failure):
      return 0
    }
  }
}

