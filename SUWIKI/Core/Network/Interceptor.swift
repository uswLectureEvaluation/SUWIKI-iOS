//
//  Interceptor.swift
//  SUWIKI
//
//  Created by 한지석 on 2/5/24.
//

import Foundation

import Keychain

import Alamofire

final class BaseInterceptor: RequestInterceptor {
  
  let keychainManager = KeychainManager.shared
  private let lock = NSLock()
  
  /// 변수에 urlRequest를 복사하지 말고 refresh 토큰일경우 그대로 한번 보내보자
  func adapt(
    _ urlRequest: URLRequest,
    for session: Session,
    completion: @escaping (Result<URLRequest, Error>) -> Void
  ) {
    print(#function)
    var request = urlRequest
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    if request.url?.absoluteString.contains("/refresh") == false {
      if let accessToken = keychainManager.read(token: .AccessToken) {
        request.setValue(accessToken, forHTTPHeaderField: "Authorization")
      }
    } else {
      if let refreshToken = keychainManager.read(token: .RefreshToken) {
        print("Hi")
        request.setValue(refreshToken, forHTTPHeaderField: "Authorization")
      }
    }
    completion(.success(request))
  }
  
  //    func retry(
  //        _ request: Request,
  //        for session: Session,
  //        dueTo error: Error,
  //        completion: @escaping (RetryResult) -> Void
  //    ) {
  //        lock.lock()
  //        defer { lock.unlock() }
  //        guard let refreshToken = keychainManager.read(token: .RefreshToken),
  //              request.response?.statusCode == 401,
  //              let urlString = request.response?.url?.absoluteString,
  //              !urlString.contains("refresh") else {
  //            completion(.doNotRetryWithError(error))
  //            return
  //        }
  //        let target = APITarget.User.refresh(DTO.RefreshRequest(authorization: refreshToken))
  //        APIProvider.requestRefreshToken(DTO.RefreshResponse.self, target: target) { [weak self] response in
  //            switch response.result {
  //            case .success:
  //                guard let tokens = response.value,
  //                      let self = self else {
  //                    completion(.doNotRetry)
  //                    return
  //                }
  //                self.keychainManager.create(token: .AccessToken, value: tokens.AccessToken)
  //                self.keychainManager.create(token: .RefreshToken, value: tokens.RefreshToken)
  //                completion(.retry)
  //            case .failure:
  //                print("@Log retry error")
  //                completion(.doNotRetryWithError(error))
  //            }
  //        }
  //    }
}

