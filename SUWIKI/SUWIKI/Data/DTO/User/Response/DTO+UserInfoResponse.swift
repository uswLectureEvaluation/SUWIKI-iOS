//
//  DTO+UserInfoResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 4/4/24.
//

import Foundation

import Domain

extension DTO {
    struct UserInfoResponse: Decodable {
        let loginId: String
        let email: String
        let point: Int
        let writtenEvaluation: Int
        let writtenExam: Int
        let viewExam: Int
    }
}

extension DTO.UserInfoResponse {
    var entity: UserInfo {
        UserInfo(
            id: loginId,
            email: email,
            point: point,
            writtenEvaluationPosts: writtenEvaluation,
            writtenExamPosts: writtenExam,
            purchasedExamPosts: viewExam
        )
    }
}
