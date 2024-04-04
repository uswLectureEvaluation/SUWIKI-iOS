//
//  Announcement.swift
//  SUWIKI
//
//  Created by 한지석 on 4/3/24.
//

import Foundation

struct Announcement: Identifiable, Hashable {
    let id: Int
    let title: String
    let date: String
    let content: String?

    init(
        id: Int,
        title: String,
        date: String,
        content: String? = nil
    ) {
        self.id = id
        self.title = title
        self.date = date
        self.content = content
    }
}
