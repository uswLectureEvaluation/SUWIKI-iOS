//
//  DTO+PurchasedExamPostsResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 4/8/24.
//

import Foundation

extension DTO {
    struct FetchPurchasedExamPostsResponse: Decodable {
        let posts: [PurchasedExamPosts]
        let statusCode: Int?
        let message: String?

        enum CodingKeys: String, CodingKey {
            case posts = "data"
            case statusCode
            case message
        }
    }
}

extension DTO.FetchPurchasedExamPostsResponse {
    struct PurchasedExamPosts: Decodable {
        let id: Int
        let professor: String
        let lectureName: String
        let majorType: String
        let createDate: String

        var entity: PurchasedPost {
            PurchasedPost(id: id,
                          name: lectureName,
                          date: createDate.formatDate())
        }
    }
}
