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

extension ExamPost {
    static let MockData = ExamPost(id: 34500435098543908,
                                   semester: "1233-3",
                                   examType: "1233-3",
                                   sourceOfExam: "몰라, 너가, 알아내",
                                   difficulty: "개어려움~",
                                   content: 
"""
ABCDEFG, HIGJEOF< werojwerpfds, ewfnowwfpia!dsafmleffe\n 
jeABCDEFG, HIGJEOF< werojwerpfds, ewfnowwfpia!dsafmleffe\n wefpojwopjfewjfpwfjew
""")
}
