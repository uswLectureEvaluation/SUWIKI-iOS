//
//  DTO+FetchAnnouncementResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 4/3/24.
//

import Foundation

import Domain

extension DTO {
  public struct FetchAnnouncementResponse: Decodable {
    public let announcements: [FetchAnnouncement]
    public let statusCode: Int?
    public let message: String?
    
    public init(
      announcements: [FetchAnnouncement],
      statusCode: Int?,
      message: String?
    ) {
      self.announcements = announcements
      self.statusCode = statusCode
      self.message = message
    }
    
    enum CodingKeys: String, CodingKey {
      case announcements = "data"
      case statusCode
      case message
    }
  }
}

extension DTO.FetchAnnouncementResponse {
  public struct FetchAnnouncement: Decodable {
    /// 공지사항 ID
    public let id: Int
    /// 공지사항 제목
    public let title: String
    /// 수정
    public let modifiedDate: String
    
    var entity: Announcement {
      Announcement(id: id,
                   title: title,
                   date: modifiedDate.formatDate())
    }
  }
}
