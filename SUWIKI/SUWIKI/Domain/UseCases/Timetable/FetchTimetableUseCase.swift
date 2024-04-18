//
//  FetchTimetableUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/13/24.
//

import Foundation

import DIContainer

protocol FetchTimetableUseCase {
    func execute(id: String) -> Timetable?
}

final class DefaultFetchTimetableUseCase: FetchTimetableUseCase {
    @Inject var repository: TimetableRepository

    func execute(id: String) -> Timetable? {
        return repository.fetchTimetable(id: id)
    }
}
