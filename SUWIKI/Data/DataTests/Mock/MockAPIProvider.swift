//
//  MockAPIProvider.swift
//  DataTests
//
//  Created by 한지석 on 5/27/24.
//

import Foundation

import Network

final class MockAPIProvider: APIProviderProtocol {

    private var responses: [String: Any] = [:]
    var isErrorOccured = false

    func setResponse<T: Decodable>(
        _ object: T.Type,
        response: T
    ) {
        let key = String(describing: object)
        responses[key] = response
    }

    func request<T: Decodable>(
        _ object: T.Type,
        target: TargetType
    ) async throws -> T {
        if isErrorOccured {
            throw NSError(domain: "MockError", code: 0)
        }
        let key = String(describing: object)
        guard let response = responses[key] as? T else {
            fatalError("Unmocked request type: \(object)")
        }

        return response
    }

    func request(target: TargetType) async throws -> Bool {
        return !isErrorOccured ? true : false
    }
}
