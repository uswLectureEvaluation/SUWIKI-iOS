//
//  FetchMajorsUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/14/24.
//

import Foundation

protocol FetchMajorsUseCase {
    func execute() -> [String]
}

final class DefaultFetchMajorsUseCase: FetchMajorsUseCase {
    @Inject var repository: TimetableRepository

    func execute() -> [String] {
        return repository.fetchMajors()
    }
}
