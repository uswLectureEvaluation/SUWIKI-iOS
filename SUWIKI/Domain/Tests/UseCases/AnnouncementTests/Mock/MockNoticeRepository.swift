//
//  MockNoticeRepository.swift
//  DomainTests
//
//  Created by 한지석 on 5/10/24.
//

import Foundation

import Domain

final class MockNoticeRepository: NoticeRepository {

    var isFetchCalled = false
    var isFetchDetailCalled = false

    func fetch() async throws -> [Domain.Announcement] {
        if isFetchCalled {
            return [Announcement(id: 1, title: "", date: "", content: "Hiyo")]
        } else {
            return []
        }
    }
    
    func fetchDetail(id: Int) async throws -> Domain.Announcement {
        if isFetchDetailCalled {
            return Announcement(id: id, title: "", date: "", content: "hi")
        } else {
            return Announcement(id: 999, title: "", date: "")
        }
    }
}
