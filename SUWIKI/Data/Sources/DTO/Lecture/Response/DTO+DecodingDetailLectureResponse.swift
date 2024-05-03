//
//  DTO+DecodingDetailLectureResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 2/6/24.
//

import Foundation

extension DTO {
    struct DecodingDetailLectureResponse: Decodable {
        let statusCode: Int?
        let message: String?
        let detailLecture: DTO.DetailLectureResponse

        enum CodingKeys: String, CodingKey {
            case statusCode
            case message
            case detailLecture = "data"
        }
    }
}
