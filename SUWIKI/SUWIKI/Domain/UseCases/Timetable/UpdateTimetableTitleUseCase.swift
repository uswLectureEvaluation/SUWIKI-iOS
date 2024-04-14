//
//  SaveTimetableTitleUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/14/24.
//

import Foundation

protocol UpdateTimetableTitleUseCase {
    func execute(id: String, title: String)
}

final class DefaultUpdateTimetableTitleUseCase: UpdateTimetableTitleUseCase {
    @Inject var repository: TimetableRepository

    func execute(id: String, title: String) {
        repository.updateTimetableTitle(id: id, title: title)
    }
}
