//
//  APIProviderProtocol.swift
//  
//
//  Created by 한지석 on 5/27/24.
//

import Foundation

public protocol APIProviderProtocol {
    func request<T: Decodable>(
        _ object: T.Type,
        target: TargetType
    ) async throws -> T

    func request(target: TargetType) async throws -> Bool
}
