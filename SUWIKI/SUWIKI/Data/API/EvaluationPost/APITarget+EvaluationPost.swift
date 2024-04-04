//
//  APITarget+EvaluatePost.swift
//  SUWIKI
//
//  Created by 한지석 on 2/27/24.
//

import Foundation

import Alamofire

extension APITarget {
    enum EvaluationPost: TargetType {
        case fetchEvaluatePosts(DTO.FetchEvaluatePostRequest)
        case writeEvaluatePost(DTO.WriteEvaluatePostRequest)
    }
}

extension APITarget.EvaluationPost {
    var targetURL: URL {
        URL(string: APITarget.baseURL + "evaluate-posts")!
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchEvaluatePosts:
            return .get
        case .writeEvaluatePost:
            return .post
        }
    }

    var path: String {
        switch self {
        case .fetchEvaluatePosts:
            return ""
        case .writeEvaluatePost:
            return ""
        }
    }

    var parameters: RequestParameter {
        switch self {
        case let .fetchEvaluatePosts(fetchEvaluatePostRequest):
            return .query(fetchEvaluatePostRequest)
        case let .writeEvaluatePost(writeEvaluatePostRequest):
            return .both(query: writeEvaluatePostRequest.lectureInfo,
                         json: writeEvaluatePostRequest.post)
        }
    }
}
