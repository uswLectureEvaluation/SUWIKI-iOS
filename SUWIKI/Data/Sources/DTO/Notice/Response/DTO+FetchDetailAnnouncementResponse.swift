//
//  DTO+FetchDetailAnnouncementResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 4/3/24.
//

import Foundation

import Domain

extension DTO {
    public struct FetchDetailAnnouncementResponse: Decodable {
        public let announcement: FetchDetailAnnouncement
        public let statusCode: Int?
        public let message: String?

        enum CodingKeys: String, CodingKey {
            case announcement = "data"
            case statusCode
            case message
        }
    }
}

extension DTO.FetchDetailAnnouncementResponse {
    public struct FetchDetailAnnouncement: Decodable {
        public let id: Int
        public let title: String
        public let modifiedDate: String
        public let content: String

        public init(
            id: Int,
            title: String,
            modifiedDate: String,
            content: String
        ) {
            self.id = id
            self.title = title
            self.modifiedDate = modifiedDate
            self.content = content
        }

        var entity: Announcement {
            Announcement(id: id,
                         title: title,
                         date: modifiedDate.formatDate(),
                         content: content)
        }
    }
}
