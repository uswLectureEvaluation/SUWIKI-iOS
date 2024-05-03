//
//  DTO+CheckDuplicatedEmailResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 4/10/24.
//

import Foundation

extension DTO {
    struct CheckDuplicatedEmailResponse: Decodable {
        let overlap: Bool
    }
}
