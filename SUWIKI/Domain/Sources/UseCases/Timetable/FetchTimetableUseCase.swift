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
    ) -> UserTimetable?
}

public final class DefaultFetchTimetableUseCase: FetchTimetableUseCase {
    @Inject private var repository: TimetableRepository

    public init() { }

    public func execute(
        id: String
    ) -> UserTimetable? {
        let result = repository.fetchTimetable(id: id)
        switch result {
        case .success(let userTimetable):
            return userTimetable
        case .failure:
            return nil
        }
    }
}
