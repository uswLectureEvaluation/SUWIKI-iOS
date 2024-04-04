//
//  DTO+FetchAnnouncementResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 4/3/24.
//

import Foundation

extension DTO {
    struct FetchAnnouncementResponse: Decodable {
        let announcements: [FetchAnnouncement]
        let statusCode: Int?
        let message: String?

        enum CodingKeys: String, CodingKey {
            case announcements = "data"
            case statusCode
            case message
        }
    }
}

extension DTO.FetchAnnouncementResponse {
    struct FetchAnnouncement: Decodable {
        /// 공지사항 ID
        let id: Int
        /// 공지사항 제목
        let title: String
        /// 수정
        let modifiedDate: String

        var entity: Announcement {
            Announcement(id: id,
                         title: title,
                         date: modifiedDate.formatDate())
        }
    }
}
