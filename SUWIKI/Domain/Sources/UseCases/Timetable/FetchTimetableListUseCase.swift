//
//  FetchTimetableListUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/14/24.
//

import Foundation

import DIContainer

public protocol FetchTimetableListUseCase {
    func execute() -> [UserTimetable]
}

public final class DefaultFetchTimetableListUseCase: FetchTimetableListUseCase {
    @Inject private var repository: TimetableRepository

    public init() { }

    public func execute() -> [UserTimetable] {
        let result = repository.fetchTimetableList()
        switch result {
        case .success(let userTimetable):
            return userTimetable
        case .failure:
            return []
        }
    }
}
