//
//  DTO+PurchasedExamPostsResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 4/8/24.
//

import Foundation

extension DTO {
    struct PurchasedExamPostsResponse: Decodable {
        let posts: [String]
        let statusCode: Int?
        let message: String?

        enum CodingKeys: String, CodingKey {
            case posts = "data"
            case statusCode
            case message
        }
    }
}

extension DTO.PurchasedExamPostsResponse {
    struct PurchasedExamPosts: Decodable {
        let id: Int
        let professor: String
        let lectureName: String
        let majorType: String
        let createDate: String
    }
}
