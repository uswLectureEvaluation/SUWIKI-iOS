//
//  APITarget+Notice.swift
//  SUWIKI
//
//  Created by 한지석 on 4/3/24.
//

import Foundation

import Alamofire

extension APITarget {
    enum Notice: TargetType {
        case fetchAnnouncements
        case fetchDetailAnnouncement(DTO.FetchDetailAnnouncementRequest)
    }
}

extension APITarget.Notice {
    var targetURL: URL {
        URL(string: APITarget.baseURL + "notice")!
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchAnnouncements:
            return .get
        case .fetchDetailAnnouncement:
            return .get
        }
    }

    var path: String {
        switch self {
        case .fetchAnnouncements:
            "/all"
        case .fetchDetailAnnouncement:
            ""
        }
    }

    var parameters: RequestParameter {
        switch self {
        case .fetchAnnouncements:
            return .plain
        case let .fetchDetailAnnouncement(fetchDetailAnnouncementRequest):
            return .query(fetchDetailAnnouncementRequest)
        }
    }
}
