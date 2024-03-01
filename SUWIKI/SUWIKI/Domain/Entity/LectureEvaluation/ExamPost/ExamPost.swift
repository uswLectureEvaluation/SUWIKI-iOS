//
//  ExamPost.swift
//  SUWIKI
//
//  Created by 한지석 on 3/1/24.
//

import Foundation

struct ExamPost: Identifiable {
    let id: Int
    let semester: String
    let examType: String
    let sourceOfExam: String
    let difficulty: String
    let content: String
}
