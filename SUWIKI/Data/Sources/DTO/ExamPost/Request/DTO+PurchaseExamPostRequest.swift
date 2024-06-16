//
//  DTO+PurchaseExamPostRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 3/30/24.
//

import Foundation

extension DTO {
  public struct PurchaseExamPostRequest: Encodable {
    public let lectureId: Int

    public init(lectureId: Int) {
      self.lectureId = lectureId
    }
  }
}
