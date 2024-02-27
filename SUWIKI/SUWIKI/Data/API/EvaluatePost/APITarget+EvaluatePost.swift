//
//  APITarget+EvaluatePost.swift
//  SUWIKI
//
//  Created by 한지석 on 2/27/24.
//

import Foundation

import Alamofire

extension APITarget {
    enum EvaluatePost: TargetType {
        case fetchEvaluatePosts(DTO.FetchEvaluatePostRequest)
    }
}

extension APITarget.EvaluatePost {
    var targetURL: URL {
        URL(string: APITarget.baseURL + "evaluate-posts")!
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchEvaluatePosts:
            return .get
        }
    }

    var path: String {
        switch self {
        case .fetchEvaluatePosts:
            ""
        }
    }

    var parameters: RequestParameter {
        switch self {
        case let .fetchEvaluatePosts(fetchEvaluatePostRequest):
            return .query(fetchEvaluatePostRequest)
        }
    }
}
