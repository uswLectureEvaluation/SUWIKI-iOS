//
//  DTO+DetailLectureRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 2/5/24.
//

import Foundation

extension DTO {
  public struct DetailLectureRequest: Encodable {
    /// 강의 ID
    public let lectureId: Int
    
    public init(lectureId: Int) {
      self.lectureId = lectureId
    }
  }
}
