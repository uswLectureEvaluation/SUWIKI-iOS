//
//  DTO+CheckDuplicatedIdResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 4/10/24.
//

import Foundation

extension DTO {
    public struct CheckDuplicatedIdResponse: Decodable {
        public let overlap: Bool

        public init(overlap: Bool) {
            self.overlap = overlap
        }
    }
}
