//
//  PostEnum.swift
//  SUWIKI
//
//  Created by 한지석 on 3/3/24.
//

import Foundation
import SwiftUI

enum DifficultyType: Int, CaseIterable {
  case notSelected
  case hard
  case normal
  case easy

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

  var exam: String {
    switch self {
    case .notSelected:
      ""
    case .easy:
      "쉬움"
    case .normal:
      "보통"
    case .hard:
      "어려움"
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

  var examWidth: CGFloat {
    switch self {
    case .notSelected:
      0
    case .easy:
      35
    case .normal:
      35
    case .hard:
      46
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

enum HomeworkType: Int, CaseIterable {
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

enum TeamplayType: Int, CaseIterable {
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

enum ExamInfoType: Hashable, CaseIterable {
  case notSelected
  case pastExams
  case textbook
  case takeNotes
  case application
  case practice
  case assignment
  case ppt

  var description: String {
    switch self {
    case .notSelected:
      ""
    case .pastExams:
      "족보"
    case .textbook:
      "교재"
    case .takeNotes:
      "필기"
    case .application:
      "응용"
    case .practice:
      "실습"
    case .assignment:
      "과제"
    case .ppt:
      "PPT"
    }
  }
}
