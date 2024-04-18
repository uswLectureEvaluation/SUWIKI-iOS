//
//  SaveTimetableTitleUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/14/24.
//

import Foundation

import DIContainer

protocol UpdateTimetableTitleUseCase {
    func execute(id: String, title: String)
}

final class DefaultUpdateTimetableTitleUseCase: UpdateTimetableTitleUseCase {
    @Inject var repository: TimetableRepository

    func execute(id: String, title: String) {
        repository.updateTimetableTitle(id: id, title: title)
    }
}
