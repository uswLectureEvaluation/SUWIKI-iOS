//
//  UserExamPost.swift
//  SUWIKI
//
//  Created by 한지석 on 4/5/24.
//

import Foundation

struct UserExamPost: Identifiable, Hashable {
    let id: Int
    let name: String
    let professor: String
    let major: String // 개설학과
    let selectedSemester: String
    let semesterList: String // 개설학기
    let examType: String // 중간, 기말
    let sourceOfExam: String // 시험 유형
    let difficulty: String // 난이도
    let content: String
}
