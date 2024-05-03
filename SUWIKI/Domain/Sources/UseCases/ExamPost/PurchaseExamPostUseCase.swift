//
//  PurchaseExamPostUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 3/30/24.
//

import Foundation

import DIContainer

public protocol PurchaseExamPostUseCase {
    func execute(
        id: Int
    ) async throws -> Bool
}

public final class DefaultPurchaseExamPostUseCase: PurchaseExamPostUseCase {
    @Inject private var repository: ExamPostRepository

    public init() { }

    public func execute(
        id: Int
    ) async throws -> Bool {
        try await repository.purchase(id: id)
    }
}
