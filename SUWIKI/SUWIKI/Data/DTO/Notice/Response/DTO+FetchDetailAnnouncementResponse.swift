//
//  DTO+FetchDetailAnnouncementResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 4/3/24.
//

import Foundation

extension DTO {
    struct FetchDetailAnnouncementResponse: Decodable {
        let announcement: String
        let statusCode: String
        let message: String
    }
}

extension DTO.FetchDetailAnnouncementResponse {
    struct FetchDetailAnnouncement {
        let id: Int
        let title: String
        let modifiedDate: String
        let content: String
    }
}
