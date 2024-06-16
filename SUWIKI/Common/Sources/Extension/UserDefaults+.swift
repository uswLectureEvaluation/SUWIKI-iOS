//
//  UserDefaults+.swift
//  SUWIKI
//
//  Created by 한지석 on 1/7/24.
//

import Foundation

extension UserDefaults {
  static public var shared: UserDefaults {
    let appGroupId = "group.sozohoy.suwiki"
    return UserDefaults(suiteName: appGroupId)!
  }
}
