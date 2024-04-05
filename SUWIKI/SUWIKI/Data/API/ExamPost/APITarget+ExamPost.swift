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
        case writeExamPost(DTO.WriteExamPostRequest)
        case purchaseExamPost(DTO.PurchaseExamPostRequest)
        case fetchUserExamPosts
        case updateExamPost(DTO.UpdateExamPostRequest)
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
        case .writeExamPost:
            return .post
        case .purchaseExamPost:
            return .post
        case .fetchUserExamPosts:
            return .get
        case .updateExamPost:
            return .put
        }
    }

    var path: String {
        switch self {
        case .fetchExamPosts:
            ""
        case .writeExamPost:
            ""
        case .purchaseExamPost:
            "/purchase"
        case .fetchUserExamPosts:
            "/written"
        case .updateExamPost:
            ""
        }
    }

    var parameters: RequestParameter {
        switch self {
        case let .fetchExamPosts(fetchExamPosts):
            return .query(fetchExamPosts)
        case let .writeExamPost(writeExamPost):
            return .both(query: writeExamPost.lectureInfo, 
                         json: writeExamPost.post)
        case let .purchaseExamPost(purchaseExamPost):
            return .query(purchaseExamPost)
        case .fetchUserExamPosts:
            return .plain
        case let .updateExamPost(updateExamPostRequest):
            return .both(query: updateExamPostRequest.lectureInfo,
                         json: updateExamPostRequest.post)
        }
    }
}
