//
//  EvaluatePost.swift
//  SUWIKI
//
//  Created by 한지석 on 2/27/24.
//

import Foundation

struct EvaluationPost: Identifiable {
    let id: Int
    let selectedSemester: String
    let totalAvarage: Double
    let content: String
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
