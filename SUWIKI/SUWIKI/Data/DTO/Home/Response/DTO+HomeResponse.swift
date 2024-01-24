//
//  DTO+HomeResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 1/24/24.
//

import Foundation

extension DTO {
    struct HomeResponse: Codable {
        /// 강의 데이터
        let lecture: [DTO.Lecture]
        /// 강의 데이터 갯수 - 불필요할 수 있음.
        let count: Int
    }
}
