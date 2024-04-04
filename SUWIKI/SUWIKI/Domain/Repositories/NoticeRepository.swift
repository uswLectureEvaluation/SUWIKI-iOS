//
//  NoticeRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 4/3/24.
//

import Foundation

protocol NoticeRepository {
    func fetch() async throws -> [Announcement]
    func fetchDetail(id: Int) async throws -> Announcement
}
