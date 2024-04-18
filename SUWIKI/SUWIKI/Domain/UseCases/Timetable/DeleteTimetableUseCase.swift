//
//  DeleteTimetableUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/14/24.
//

import Foundation

import DIContainer

protocol DeleteTimetableUseCase {
    func execute(id: String)
}

final class DefaultDeleteTimeTableUseCase: DeleteTimetableUseCase {
    @Inject var repository: TimetableRepository

    func execute(id: String) {
        repository.deleteTimetable(id: id)
    }
}
