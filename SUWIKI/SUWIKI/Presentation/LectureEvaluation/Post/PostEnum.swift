//
//  PostEnum.swift
//  SUWIKI
//
//  Created by 한지석 on 3/3/24.
//

import Foundation
import SwiftUI

enum DifficultyType: CaseIterable {
    case notSelected
    case easy
    case normal
    case hard

    var description: String {
        switch self {
        case .notSelected:
            ""
        case .easy:
            "너그러움"
        case .normal:
            "보통"
        case .hard:
            "까다로움"
        }
    }

    var font: UIColor {
        switch self {
        case .notSelected:
            return .gray95
        case .easy:
            return .easyFont
        case .normal:
            return .normalFont
        case .hard:
            return .hardFont
        }
    }

    var background: UIColor {
        switch self {
        case .notSelected:
            return .grayF6
        case .easy:
            return .easyBackground
        case .normal:
            return .normalBackground
        case .hard:
            return .hardBackground
        }
    }

    var width: CGFloat {
        switch self {
        case .notSelected:
            0
        case .easy:
            57
        case .normal:
            35
        case .hard:
            57
        }
    }

    var point: Int {
        switch self {
        case .notSelected:
            0
        case .easy:
            2
        case .normal:
            1
        case .hard:
            0
        }
    }
}

enum HomeworkType: CaseIterable {
    case notSelected
    case none
    case normal
    case many

    var description: String {
        switch self {
        case .notSelected:
            ""
        case .none:
            "없음"
        case .normal:
            "보통"
        case .many:
            "많음"
        }
    }

    var font: UIColor {
        switch self {
        case .notSelected:
            return .gray95
        case .none:
            return .easyFont
        case .normal:
            return .normalFont
        case .many:
            return .hardFont
        }
    }

    var background: UIColor {
        switch self {
        case .notSelected:
            return .grayF6
        case .none:
            return .easyBackground
        case .normal:
            return .normalBackground
        case .many:
            return .hardBackground
        }
    }

    var point: Int {
        switch self {
        case .notSelected:
            0
        case .none:
            0
        case .normal:
            1
        case .many:
            2
        }
    }
}

enum TeamplayType: CaseIterable {
    case notSelected
    case none
    case some

    var description: String {
        switch self {
        case .notSelected:
            ""
        case .none:
            "없음"
        case .some:
            "있음"
        }
    }

    var font: UIColor {
        switch self {
        case .notSelected:
            return .gray95
        case .none:
            return .easyFont
        case .some:
            return .hardFont
        }
    }

    var background: UIColor {
        switch self {
        case .notSelected:
            return .grayF6
        case .none:
            return .easyBackground
        case .some:
            return .hardBackground
        }
    }

    var point: Int {
        switch self {
        case .notSelected:
            0
        case .none:
            0
        case .some:
            1
        }
    }
}
