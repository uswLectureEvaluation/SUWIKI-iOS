//
//  DTO+DetailLectureRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 2/5/24.
//

import Foundation

extension DTO {
    struct DetailLectureRequest: Encodable {
        /// 강의 ID
        let lectureId: Int
    }
}
