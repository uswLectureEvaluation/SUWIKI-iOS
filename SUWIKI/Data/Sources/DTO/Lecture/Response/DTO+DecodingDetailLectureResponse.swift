//
//  DTO+DecodingDetailLectureResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 2/6/24.
//

import Foundation

extension DTO {
    public struct DecodingDetailLectureResponse: Decodable {
        public let statusCode: Int?
        public let message: String?
        public let detailLecture: DTO.DetailLectureResponse

        public init(
            statusCode: Int?,
            message: String?,
            detailLecture: DTO.DetailLectureResponse
        ) {
            self.statusCode = statusCode
            self.message = message
            self.detailLecture = detailLecture
        }

        enum CodingKeys: String, CodingKey {
            case statusCode
            case message
            case detailLecture = "data"
        }
    }
}
