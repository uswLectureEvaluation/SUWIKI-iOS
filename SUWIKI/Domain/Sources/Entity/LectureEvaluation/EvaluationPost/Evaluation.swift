//
//  EvaluatePost.swift
//  SUWIKI
//
//  Created by 한지석 on 2/27/24.
//

import Foundation

public struct Evaluation {
    public let written: Bool
    public let posts: [EvaluationPost]

    public init(
        written: Bool,
        posts: [EvaluationPost]
    ) {
        self.written = written
        self.posts = posts
    }
}

public struct EvaluationPost: Identifiable {
    public let id: Int
    public let selectedSemester: String
    public let totalAvarage: Double
    public let content: String

    public init(
        id: Int,
        selectedSemester: String,
        totalAvarage: Double,
        content: String
    ) {
        self.id = id
        self.selectedSemester = selectedSemester
        self.totalAvarage = totalAvarage
        self.content = content
    }
}

extension EvaluationPost {
    static let mockData: [EvaluationPost] = [
        EvaluationPost(id: Int.random(in: 0...11102321031213),
                     selectedSemester: "2022-1",
                     totalAvarage: 3.4,
                     content: "거의 한 학기 팀플하시는데...팀원 잘 만나면 잘 모르겠네요.\n굉장히 오픈 마인드시긴해요.\n전 이 교수님 적응하기 힘들었어요."),
        EvaluationPost(id: Int.random(in: 0...11102321031213),
                     selectedSemester: "2025-1",
                     totalAvarage: 1.2,
                     content: "거의 한 학기 팀플하시는데...팀원 잘 만나면 잘 모르겠네요.\n굉장히 오픈 마인드시긴해요.\n전 이 교수님 적응하기 힘들었어요."),
        EvaluationPost(id: Int.random(in: 0...11102321031213),
                     selectedSemester: "2022-1",
                     totalAvarage: 4.5,
                     content: "거의 한 학기 팀플하시는데...팀원 잘 만나면 잘 모르겠네요.\n굉장히 오픈 마인드시긴해요.\n전 이 교수님 적응하기 힘들었어요.")
    ]
}
