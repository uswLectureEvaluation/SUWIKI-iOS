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

    var font: Color {
        switch self {
        case .notSelected:
            Color(uiColor: .gray95)
        case .easy:
            Color(uiColor: .easyFont)
        case .normal:
            Color(uiColor: .normalFont)
        case .hard:
            Color(uiColor: .hardFont)
        }
    }

    var background: Color {
        switch self {
        case .notSelected:
            Color(uiColor: .grayF6)
        case .easy:
            Color(uiColor: .easyBackground)
        case .normal:
            Color(uiColor: .normalBackground)
        case .hard:
            Color(uiColor: .hardBackground)
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

    var font: Color {
        switch self {
        case .notSelected:
            Color(uiColor: .gray95)
        case .none:
            Color(uiColor: .easyFont)
        case .normal:
            Color(uiColor: .normalFont)
        case .many:
            Color(uiColor: .hardFont)
        }
    }

    var background: Color {
        switch self {
        case .notSelected:
            Color(uiColor: .grayF6)
        case .none:
            Color(uiColor: .easyBackground)
        case .normal:
            Color(uiColor: .normalBackground)
        case .many:
            Color(uiColor: .hardBackground)
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

    var font: Color {
        switch self {
        case .notSelected:
            Color(uiColor: .gray95)
        case .none:
            Color(uiColor: .easyFont)
        case .some:
            Color(uiColor: .hardFont)
        }
    }

    var background: Color {
        switch self {
        case .notSelected:
            Color(uiColor: .grayF6)
        case .none:
            Color(uiColor: .easyBackground)
        case .some:
            Color(uiColor: .hardBackground)
        }
    }
}
