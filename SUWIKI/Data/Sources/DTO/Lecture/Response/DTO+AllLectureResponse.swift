//
//  DTO+HomeResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 1/24/24.
//

import Foundation

extension DTO {
    public struct AllLectureResponse: Codable {
        /// 강의 데이터
        public let lecture: [DTO.LectureResponse]
        /// 강의 데이터 갯수 - 불필요할 수 있음.
        public let count: Int

        public init(
            lecture: [DTO.LectureResponse],
            count: Int
        ) {
            self.lecture = lecture
            self.count = count
        }

        enum CodingKeys: String, CodingKey {
            case lecture = "data"
            case count
        }
    }
}
