//
//  DTO+FetchExamPostsRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 3/1/24.
//

import Foundation

extension DTO {
    public struct FetchExamPostsRequest: Encodable {
        /// 강의 ID
        public let lectureId: Int
        /// 페이지(1...)
        public let page: Int

        public init(
            lectureId: Int,
            page: Int
        ) {
            self.lectureId = lectureId
            self.page = page
        }
    }
}
