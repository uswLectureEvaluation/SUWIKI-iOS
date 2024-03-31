//
//  PurchaseExamPostUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 3/30/24.
//

import Foundation

protocol PurchaseExamPostUseCase {
    func execute(id: Int) async throws -> Bool
}

final class DefaultPurchaseExamPostUseCase: PurchaseExamPostUseCase {

    @Inject var repository: ExamPostRepository

    func execute(id: Int) async throws -> Bool {
        try await repository.purchase(id: id)
    }
}
