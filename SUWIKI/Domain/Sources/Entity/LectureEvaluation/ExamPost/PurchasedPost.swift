//
//  PurchasedPost.swift
//  SUWIKI
//
//  Created by 한지석 on 4/8/24.
//

import Foundation

public struct PurchasedPost: Identifiable, Hashable {
  public let id: Int
  public let name: String
  public let date: String
  
  public init(
    id: Int,
    name: String,
    date: String
  ) {
    self.id = id
    self.name = name
    self.date = date
  }
}
