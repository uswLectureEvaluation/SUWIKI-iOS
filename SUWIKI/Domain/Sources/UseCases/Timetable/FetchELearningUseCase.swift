//
//  FetchELearningUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/14/24.
//

import Foundation

import DIContainer

public protocol FetchELearningUseCase {
    func execute(
        id: String
    ) -> [TimetableCourse]
}

public final class DefaultFetchELearningUseCase: FetchELearningUseCase {
    @Inject private var repository: TimetableRepository

    public init() { }

    public func execute(
        id: String
    ) -> [TimetableCourse] {
        return repository.fetchELearning(id: id)
    }
}
