//
//  SaveTimetableTitleUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/14/24.
//

import Foundation

import DIContainer

public protocol UpdateTimetableTitleUseCase {
    func execute(
        id: String,
        title: String
    )
}

public final class DefaultUpdateTimetableTitleUseCase: UpdateTimetableTitleUseCase {
    @Inject private var repository: TimetableRepository

    public init() { }

    public func execute(
        id: String,
        title: String
    ) {
        repository.updateTimetableTitle(
            id: id,
            title: title
        )
    }
}
