//
//  DTO+OverlapResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 2/3/24.
//

import Foundation

extension DTO {
    struct OverlapResponse: Codable {
        /// 중복 확인 불리언 값
        let overlap: Bool
    }
}
