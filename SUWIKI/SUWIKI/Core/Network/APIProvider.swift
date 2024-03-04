//
//  APIProvider.swift
//  SUWIKI
//
//  Created by 한지석 on 1/25/24.
//

import Foundation

import Alamofire

class APIProvider {
    static func request<T: Decodable>(
        _ object: T.Type,
        target: TargetType
    ) async throws -> T {
        return try await AlamofireManager
            .shared
            .session
            .request(target)
            .serializingDecodable()
            .value
        /// response()로 수정해야 함
    }

    static func request(target: TargetType) async throws -> Int? {
        let dataRequest = await AlamofireManager
            .shared
            .session
            .request(target)
            .serializingData()
            .response
        let statusCode = dataRequest.response?.statusCode
        return statusCode
    }

    static func requestRefreshToken<T: Decodable>(
        _ object: T.Type,
        target: TargetType,
        completion: @escaping (DataResponse<T, AFError>) -> Void) {
            AlamofireManager
                .shared
                .session
                .request(target)
                .responseDecodable(of: object) { response in
                    completion(response)
                }
        }
}
