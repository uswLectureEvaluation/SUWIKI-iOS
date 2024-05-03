//
//  FetchTimetableUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/13/24.
//

import Foundation

import DIContainer

public protocol FetchTimetableUseCase {
    func execute(
        id: String
    ) -> Timetable?
}

public final class DefaultFetchTimetableUseCase: FetchTimetableUseCase {
    @Inject private var repository: TimetableRepository

    public init() { }

    public func execute(
        id: String
    ) -> Timetable? {
        return repository.fetchTimetable(id: id)
    }
}
