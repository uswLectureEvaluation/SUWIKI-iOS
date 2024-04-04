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
        case fetchEvaluationPosts(DTO.FetchEvaluationPostRequest)
        case writeEvaluationPost(DTO.WriteEvaluationPostRequest)
        case fetchUserEvaluationPosts
    }
}

extension APITarget.EvaluationPost {
    var targetURL: URL {
        URL(string: APITarget.baseURL + "evaluate-posts")!
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchEvaluationPosts:
            return .get
        case .writeEvaluationPost:
            return .post
        case .fetchUserEvaluationPosts:
            return .get
        }
    }

    var path: String {
        switch self {
        case .fetchEvaluationPosts:
            return ""
        case .writeEvaluationPost:
            return ""
        case .fetchUserEvaluationPosts:
            return "/written"
        }
    }

    var parameters: RequestParameter {
        switch self {
        case let .fetchEvaluationPosts(fetchEvaluatePostRequest):
            return .query(fetchEvaluatePostRequest)
        case let .writeEvaluationPost(writeEvaluatePostRequest):
            return .both(query: writeEvaluatePostRequest.lectureInfo,
                         json: writeEvaluatePostRequest.post)
        case .fetchUserEvaluationPosts:
            return .plain
        }
    }
}
