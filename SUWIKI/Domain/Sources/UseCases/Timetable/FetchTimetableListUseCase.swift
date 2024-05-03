//
//  FetchTimetableListUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/14/24.
//

import Foundation

import DIContainer

public protocol FetchTimetableListUseCase {
    func execute() -> [Timetable]
}

public final class DefaultFetchTimetableListUseCase: FetchTimetableListUseCase {
    @Inject private var repository: TimetableRepository

    public init() { }

    public func execute() -> [Timetable] {
        return repository.fetchTimetableList()
    }
}
