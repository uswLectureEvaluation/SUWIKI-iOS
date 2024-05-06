//
//  DTO+JoinResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 2/3/24.
//

import Foundation

extension DTO {
    public struct JoinResponse: Codable {
        /// 요청 성공 여부
        public let success: Bool

        public init(success: Bool) {
            self.success = success
        }
    }
}
