//
//  DTO+FetchUserExamPostsResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 4/5/24.
//

import Foundation

import Domain

extension DTO {
    struct FetchUserExamPostsResponse: Decodable {
        let posts: [UserExamPostResponse]
        let statusCode: Int?
        let message: String?

        enum CodingKeys: String, CodingKey {
            case posts = "data"
            case statusCode
            case message
        }
    }
}

extension DTO.FetchUserExamPostsResponse {
    struct UserExamPostResponse: Decodable {
        let id: Int
        let lectureName: String
        let professor: String
        let majorType: String
        let selectedSemester: String
        let semesterList: String
        let examType: String
        let examInfo: String
        let examDifficulty: String
        let content: String

        var entity: UserExamPost {
            UserExamPost(id: id,
                         name: lectureName,
                         professor: professor,
                         major: majorType,
                         selectedSemester: selectedSemester,
                         semesterList: semesterList,
                         examType: examType,
                         sourceOfExam: examInfo,
                         difficulty: examDifficulty,
                         content: content)
        }
    }
}
