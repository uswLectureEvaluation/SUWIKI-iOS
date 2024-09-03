//
//  APIProvider.swift
//  SUWIKI
//
//  Created by 한지석 on 1/25/24.
//

import Foundation

import Alamofire

@available(iOS 13, *)
public class APIProvider: APIProviderProtocol {

  public static let shared = APIProvider()
  
  public init() { }
  
  public func request<T: Decodable>(
    _ object: T.Type,
    target: TargetType
  ) async throws -> T {
    return try await AlamofireManager
      .shared
      .session
      .request(target)
      .serializingDecodable()
      .value
  }
  
  public func request(target: TargetType) async throws -> Bool {
    let dataRequest = await AlamofireManager
      .shared
      .session
      .request(target)
      .serializingData()
      .response
    let statusCode = dataRequest.response?.statusCode
    if statusCode == 200 {
      return true
    } else {
      return false
    }
  }
  
  public func requestRefreshToken<T: Decodable>(
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
