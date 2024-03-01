//
//  APITarget+ExamPost.swift
//  SUWIKI
//
//  Created by 한지석 on 3/1/24.
//

import Foundation

import Alamofire

extension APITarget {
    enum ExamPost: TargetType {
        case fetchExamPosts(DTO.FetchExamPostsRequest)
    }
}

extension APITarget.ExamPost {
    var targetURL: URL {
        URL(string: APITarget.baseURL + "exam-posts")!
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchExamPosts:
            return .get
        }
    }

    var path: String {
        switch self {
        case .fetchExamPosts:
            ""
        }
    }

    var parameters: RequestParameter {
        switch self {
        case let .fetchExamPosts(fetchExamPosts):
            return .query(fetchExamPosts)
        }
    }
}
