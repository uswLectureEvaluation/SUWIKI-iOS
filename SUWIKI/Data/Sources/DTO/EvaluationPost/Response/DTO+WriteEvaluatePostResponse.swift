//
//  DTO+WriteEvaluatePostResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 3/4/24.
//

import Foundation

extension DTO {
    public struct WriteEvaluationPostResponse: Decodable {
        public let status: String

        public init(status: String) {
            self.status = status
        }
    }
}
