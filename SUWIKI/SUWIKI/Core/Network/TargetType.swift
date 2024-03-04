//
//  TargetType.swift
//  SUWIKI
//
//  Created by 한지석 on 1/25/24.
//

import Foundation

import Alamofire

/// https://ios-development.tistory.com/731

public protocol TargetType: URLRequestConvertible {
    var targetURL: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    /// 파라미터의 종류. Query / JSON
    var parameters: RequestParameter { get }
}

public extension TargetType {
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}

extension TargetType {
    public func addParameters(_ request: URLRequest) throws -> URLRequest {
        var request = request
        switch parameters {
        case .plain:
            break

        case let .query(query):
            print("@Query - \(query)")
            request = try URLEncoding.queryString.encode(request, with: query.toDictionary())

        case let .body(json):
            request = try JSONEncoding.default.encode(request, with: json.toDictionary())

        case let .both(query, json):
            let queryRequest = try URLEncoding.queryString.encode(request, with: query.toDictionary())
            request = try JSONEncoding.default.encode(queryRequest, with: json.toDictionary())
        }
        return request
    }

    public func asURLRequest() throws -> URLRequest {
        let url = try targetURL.appending(path: path).asURL()
        var urlRequest = try URLRequest(url: url,
                                        method: method)
        if let headers = headers {
            urlRequest.headers = HTTPHeaders(headers)
        }
        urlRequest = try addParameters(urlRequest)
        print("@KOZI - \(urlRequest)")
        return urlRequest
    }
}
