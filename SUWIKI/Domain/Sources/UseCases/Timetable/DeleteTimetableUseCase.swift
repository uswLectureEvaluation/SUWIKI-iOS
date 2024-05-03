//
//  DeleteTimetableUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/14/24.
//

import Foundation

import DIContainer

public protocol DeleteTimetableUseCase {
    func execute(
        id: String
    )
}

public final class DefaultDeleteTimeTableUseCase: DeleteTimetableUseCase {
    @Inject private var repository: TimetableRepository

    public init() { }

    public func execute(
        id: String
    ) {
        repository.deleteTimetable(id: id)
    }
}
