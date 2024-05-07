//
//  UserInfoType.swift
//  SUWIKI
//
//  Created by 한지석 on 4/3/24.
//

import Foundation

enum UserInfoType: CaseIterable {
    case myPoint
    case restrictionHistory

    var title: String {
        switch self {
        case .myPoint:
            "내 포인트"
        case .restrictionHistory:
            "이용제한 내역"
        }
    }
}
