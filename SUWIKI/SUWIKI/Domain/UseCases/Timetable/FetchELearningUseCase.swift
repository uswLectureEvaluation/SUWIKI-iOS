//
//  FetchELearningUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/14/24.
//

import Foundation

import DIContainer

protocol FetchELearningUseCase {
    func execute(id: String) -> [Course]
}

final class DefaultFetchELearningUseCase: FetchELearningUseCase {
    @Inject var repository: TimetableRepository

    func execute(id: String) -> [Course] {
        return repository.fetchELearning(id: id)
    }
}
