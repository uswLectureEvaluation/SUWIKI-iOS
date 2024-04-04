//
//  DTO+FetchEvaluatePostsRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 2/8/24.
//

import Foundation

extension DTO {
    struct FetchEvaluationPostRequest: Encodable {
        /// 강의 ID
        let lectureId: Int
        /// 페이지(1...)
        let page: Int
    }
}
