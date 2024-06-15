//
//  CheckCourseVersionUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/14/24.
//

import Foundation

import DIContainer

public protocol CheckCourseVersionUseCase {
  func execute() async throws
}

public final class DefaultCheckCourseVersionUseCase: CheckCourseVersionUseCase {
  @Inject private var repository: TimetableRepository
  
  public init() { }
  
  public func execute() async throws {
    let result = try await repository.checkCourseVersion()
    switch result {
    case .success:
      break
    case .failure(let failure):
      dump(failure)
    }
  }
}
