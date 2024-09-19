//
//  DTO+FetchDetailAnnouncementRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 4/3/24.
//

import Foundation

extension DTO {
  public struct FetchDetailAnnouncementRequest: Encodable {
    public let noticeId: Int
    
    public init(noticeId: Int) {
      self.noticeId = noticeId
    }
  }
}
