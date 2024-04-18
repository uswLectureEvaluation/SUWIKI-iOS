//
//  SaveTimetableUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/13/24.
//

import Foundation

import DIContainer

protocol SaveTimetableUseCase {
    func execute(name: String, semester: String)
}

final class DefaultSaveTimetableUseCase: SaveTimetableUseCase {
    @Inject var repository: TimetableRepository

    func execute(name: String, semester: String) {
        repository.saveTimetable(name: name, semester: semester)
    }
}
