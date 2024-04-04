//
//  DTO+AllEvaluatePostsResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 2/27/24.
//

import Foundation

extension DTO {
    struct FetchEvaluationPostsResponse: Decodable {
        let posts: [DTO.EvaluationPostResponse]
        let written: Bool

        enum CodingKeys: String, CodingKey {
            case posts = "data"
            case written
        }
    }
}
