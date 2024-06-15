//
//  FetchMajorsUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/14/24.
//

import Foundation

import DIContainer

public protocol FetchMajorsUseCase {
  func execute() -> [String]
}

public final class DefaultFetchMajorsUseCase: FetchMajorsUseCase {
  @Inject private var repository: TimetableRepository
  
  public init() { }
  
  public func execute() -> [String] {
    let result = repository.fetchMajors()
    switch result {
    case .success(let majors):
      return majors
    case .failure:
      return []
    }
  }
}
