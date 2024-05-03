//
//  Announcement.swift
//  SUWIKI
//
//  Created by 한지석 on 4/3/24.
//

import Foundation

public struct Announcement: Identifiable, Hashable {
    public let id: Int
    public let title: String
    public let date: String
    public let content: String?

    public init(
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
