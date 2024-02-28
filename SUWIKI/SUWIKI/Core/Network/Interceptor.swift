//
//  Interceptor.swift
//  SUWIKI
//
//  Created by 한지석 on 2/5/24.
//

import Foundation

import Alamofire

//final class tempInterceptor: RequestInterceptor {
//    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
//        <#code#>
//    }
//}

final class BaseInterceptor: RequestInterceptor {

    let keychainManager = KeychainManager.shared

    func adapt(_ urlRequest: URLRequest, 
               for session: Session,
               completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let accessToken = keychainManager.read(token: .AccessToken) {
            request.setValue(accessToken, forHTTPHeaderField: "Authorization")
        }
        completion(.success(request))
    }

//    func adapt(
//        _ urlRequest: URLRequest,
//        for session: Session,
//        completion: @escaping (Result<URLRequest, Error>) -> Void) {
//            var request = urlRequest
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            if let accessToken = keychainManager.read(token: .AccessToken) {
//                request.setValue(accessToken, forHTTPHeaderField: "Authorization")
//            }
//            completion(.success(request))
//        }

//    func retry(_ request: Request, for session: Session, dueTo error: Error) async throws -> RetryResult {
//        print("@LOG RETRY")
//        guard let accessToken = keychainManager.read(token: .AccessToken) else {
//            return .doNotRetry
//        }
//        let target = APITarget.User.refresh(DTO.RefreshRequest(authorization: accessToken))
//        do {
//
//            let tokens = try await APIProvider.request(DTO.RefreshResponse.self, target: target)
//            keychainManager.create(token: .AccessToken, value: tokens.accessToken)
//            keychainManager.create(token: .RefreshToken, value: tokens.refreshToken)
//            return .retry
//        } catch {
//            return .doNotRetryWithError(error)
//        }
//    }
//    func retry(
//        _ request: Request,
//        for session: Session,
//        dueTo error: Error,
//        completion: @escaping (RetryResult) -> Void) {
//            print("@LOG RETRY 2")
//            guard let refreshToken = keychainManager.read(token: .RefreshToken)
//            else {
//                completion(.doNotRetry)
//                return
//            }
//            let target = APITarget.User.refresh(DTO.RefreshRequest(authorization: refreshToken))
//            Task {
//                do {
//                    let tokens = try await APIProvider.request(DTO.RefreshResponse.self, target: target)
//                    keychainManager.create(token: .AccessToken, value: tokens.accessToken)
//                    keychainManager.create(token: .RefreshToken, value: tokens.refreshToken)
//                    await MainActor.run {
//                        completion(.doNotRetry)
//                    }
//                } catch {
//                    await MainActor.run {
//                        completion(.doNotRetry)
//                    }
//                }
//            }
//        }
}

