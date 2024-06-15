//
//  SaveTimetableUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/13/24.
//

import Foundation

import DIContainer

public protocol SaveTimetableUseCase {
  func execute(
    name: String,
    semester: String
  )
}

public final class DefaultSaveTimetableUseCase: SaveTimetableUseCase {
  @Inject private var repository: TimetableRepository
  
  public init() { }
  
  public func execute(name: String, semester: String) {
    let result = repository.saveTimetable(name: name, semester: semester)
    switch result {
    case .success:
      break
    case .failure(let failure):
      dump(failure)
    }
  }
}
