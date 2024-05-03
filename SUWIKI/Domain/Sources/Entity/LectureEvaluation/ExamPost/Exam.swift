//
//  ExamPostInfo.swift
//  SUWIKI
//
//  Created by 한지석 on 3/1/24.
//

import Foundation

public struct Exam {
    public let posts: [ExamPost]
    public let isPurchased: Bool
    public let isWritten: Bool
    public let isExamPostsExists: Bool

    public init(
        posts: [ExamPost],
        isPurchased: Bool,
        isWritten: Bool,
        isExamPostsExists: Bool
    ) {
        self.posts = posts
        self.isPurchased = isPurchased
        self.isWritten = isWritten
        self.isExamPostsExists = isExamPostsExists
    }
}
