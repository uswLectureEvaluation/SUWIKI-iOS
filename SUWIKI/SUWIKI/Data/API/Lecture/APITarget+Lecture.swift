//
//  APITarget+Lecture.swift
//  SUWIKI
//
//  Created by 한지석 on 1/25/24.
//

import Foundation

import Alamofire

extension APITarget {
    enum Lecture: TargetType {
        case getHome(DTO.AllLectureRequest)
        case search(DTO.SearchLectureRequest)
        case detail(DTO.DetailLectureRequest)
    }
}

extension APITarget.Lecture {
    var targetURL: URL {
        URL(string: APITarget.baseURL + "lecture")!
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .getHome:
            return .get
        case .search:
            return .get
        case .detail:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getHome:
            "/all"
        case .search:
            "/search"
        case .detail:
            ""
        }
    }

    var parameters: RequestParameter {
        switch self {
        case let .getHome(allLectureRequest):
            return .query(allLectureRequest)
        case let .search(searchLectureRequest):
            return .query(searchLectureRequest)
        case let .detail(detailLectureRequest):
            return .query(detailLectureRequest)
        }
    }
}
