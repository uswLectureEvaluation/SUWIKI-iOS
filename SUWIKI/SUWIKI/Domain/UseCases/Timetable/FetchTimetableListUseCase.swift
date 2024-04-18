//
//  FetchTimetableListUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/14/24.
//

import Foundation

import DIContainer

protocol FetchTimetableListUseCase {
    func execute() -> [Timetable]
}

final class DefaultFetchTimetableListUseCase: FetchTimetableListUseCase {
    @Inject var repository: TimetableRepository

    func execute() -> [Timetable] {
        return repository.fetchTimetableList()
    }
}
