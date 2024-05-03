//
//  DTO+CheckDuplicatedIdRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 4/10/24.
//

import Foundation

extension DTO {
    struct CheckDuplicatedIdRequest: Encodable {
        let loginId: String
    }
}
