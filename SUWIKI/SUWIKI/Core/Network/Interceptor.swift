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
        completion: @escaping (Result<URLRequest, Error>) -> Void) {
            var request = urlRequest
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if let accessToken = keychainManager.read(token: .AccessToken) {
                request.setValue(accessToken, forHTTPHeaderField: "Authorization")
            }
            completion(.success(request))
        }

//    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
//        <#code#>
//    }
}
