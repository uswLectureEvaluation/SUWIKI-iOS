//
//  HTTPMethod.swift
//
//
//  Created by 한지석 on 5/2/24.
//

import Foundation

public struct NetworkHTTPMethod: RawRepresentable, Equatable, Hashable {
    /// `CONNECT` method.
    public static let connect = NetworkHTTPMethod(rawValue: "CONNECT")
    /// `DELETE` method.
    public static let delete = NetworkHTTPMethod(rawValue: "DELETE")
    /// `GET` method.
    public static let get = NetworkHTTPMethod(rawValue: "GET")
    /// `HEAD` method.
    public static let head = NetworkHTTPMethod(rawValue: "HEAD")
    /// `OPTIONS` method.
    public static let options = NetworkHTTPMethod(rawValue: "OPTIONS")
    /// `PATCH` method.
    public static let patch = NetworkHTTPMethod(rawValue: "PATCH")
    /// `POST` method.
    public static let post = NetworkHTTPMethod(rawValue: "POST")
    /// `PUT` method.
    public static let put = NetworkHTTPMethod(rawValue: "PUT")
    /// `QUERY` method.
    public static let query = NetworkHTTPMethod(rawValue: "QUERY")
    /// `TRACE` method.
    public static let trace = NetworkHTTPMethod(rawValue: "TRACE")

    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
