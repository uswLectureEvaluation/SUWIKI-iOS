//
//  APITarget+EvaluationPost.swift
//  Data
//
//  Created by 한지석 on 5/3/24.
//

import Foundation

import Network

extension APITarget {
    enum EvaluationPost: TargetType {
        case fetchEvaluationPosts(DTO.FetchEvaluationPostRequest)
        case writeEvaluationPost(DTO.WriteEvaluationPostRequest)
        case updateEvaluationPost(DTO.UpdateEvaluationPostRequest)
        case fetchUserEvaluationPosts
    }
}

extension APITarget.EvaluationPost {
    var targetURL: URL {
        URL(string: APITarget.baseURL + "evaluate-posts")!
    }

    var method: NetworkHTTPMethod {
        switch self {
        case .fetchEvaluationPosts:
            return .get
        case .writeEvaluationPost:
            return .post
        case .fetchUserEvaluationPosts:
            return .get
        case .updateEvaluationPost:
            return .put
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
        case .updateEvaluationPost:
            return ""
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
        case let .updateEvaluationPost(updateEvaluationPostRequest):
            return .both(query: updateEvaluationPostRequest.lectureInfo,
                         json: updateEvaluationPostRequest.post)
        }
    }
}
