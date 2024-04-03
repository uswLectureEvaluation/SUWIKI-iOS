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
        case fetchAnnouncements(DTO.FetchAnnouncementRequest)
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
        }
    }

    var path: String {
        switch self {
        case .fetchAnnouncements:
            "/all"
        }
    }

    var parameters: RequestParameter {
        switch self {
        case let .fetchAnnouncements(fetchAnnouncementRequest):
            return .query(fetchAnnouncementRequest)
        }
    }
}
