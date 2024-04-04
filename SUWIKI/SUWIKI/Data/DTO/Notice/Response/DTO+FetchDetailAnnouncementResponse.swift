//
//  DTO+FetchDetailAnnouncementResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 4/3/24.
//

import Foundation

extension DTO {
    struct FetchDetailAnnouncementResponse: Decodable {
        let announcement: FetchDetailAnnouncement
        let statusCode: Int?
        let message: String?

        enum CodingKeys: String, CodingKey {
            case announcement = "data"
            case statusCode
            case message
        }
    }
}

extension DTO.FetchDetailAnnouncementResponse {
    struct FetchDetailAnnouncement: Decodable {
        let id: Int
        let title: String
        let modifiedDate: String
        let content: String

        var entity: Announcement {
            Announcement(id: id,
                         title: title,
                         date: modifiedDate.formatDate(),
                         content: content)
        }
    }
}
