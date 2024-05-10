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
        let result = repository.deleteTimetable(id: id)
        switch result {
        case .success: break
        case .failure(let failure):
            dump(failure)
        }
    }
}
