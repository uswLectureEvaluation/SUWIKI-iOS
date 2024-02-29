//
//  Interceptor.swift
//  SUWIKI
//
//  Created by 한지석 on 2/5/24.
//

import Foundation

import Alamofire

final class BaseInterceptor: RequestInterceptor {

    let keychainManager = KeychainManager.shared

    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        var request = urlRequest
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let accessToken = keychainManager.read(token: .AccessToken) {
            request.setValue(accessToken, forHTTPHeaderField: "Authorization")
        }
        completion(.success(request))
    }

    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        guard let refreshToken = keychainManager.read(token: .RefreshToken), request.response?.statusCode == 401 else {
            return completion(.doNotRetryWithError(error))
        }
        let target = APITarget.User.refresh(DTO.RefreshRequest(authorization: refreshToken))
        APIProvider.requestRefreshToken(DTO.RefreshResponse.self, target: target) { [weak self] response in
            switch response.result {
            case .success:
                guard let tokens = response.value,
                      let self = self else {
                    completion(.doNotRetry)
                    return
                }
                self.keychainManager.create(token: .AccessToken, value: tokens.accessToken)
                self.keychainManager.create(token: .RefreshToken, value: tokens.refreshToken)
                completion(.retry)
            case .failure:
                completion(.doNotRetryWithError(error))
            }
        }
    }
}

