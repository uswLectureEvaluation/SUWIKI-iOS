//
//  ManageButtonType.swift
//  SUWIKI
//
//  Created by 한지석 on 4/3/24.
//

import Foundation
import SwiftUI

enum ManageButtonType: CaseIterable {
  case announcement
  case inquire
  case manageAccount

  var title: String {
    switch self {
    case .announcement:
      "공지사항"
    case .inquire:
      "문의하기"
    case .manageAccount:
      "계정관리"
    }
  }

  var image: Image {
    switch self {
    case .announcement:
      Image(systemName: "speaker.fill")
    case .inquire:
      Image(systemName: "ellipsis.message.fill")
    case .manageAccount:
      Image(systemName: "gearshape.fill")
    }
  }
}
