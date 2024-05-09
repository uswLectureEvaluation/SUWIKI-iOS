//
//  MockExamPostRepository.swift
//  Domain
//
//  Created by 한지석 on 5/9/24.
//

import Foundation

import Domain

final class MockExamPostRepository: ExamPostRepository {

    /// given
    var isWriteCalled = false
    var isFetchCalled = false
    var isFetchPurchasedExamPostsCalled = false
    var isUpdateCalled = false
    var isPurchaseCalled = false
    var isFetchUserPostCalled = false

    /// then
    var id: Int? = nil


    func fetch(id: Int, page: Int) async throws -> Exam {
        if isFetchCalled {
            return Exam(posts: [ExamPost(id: 1,
                                         semester: "",
                                         examType: "",
                                         sourceOfExam: "",
                                         difficulty: "",
                                         content: "")], 
                        isPurchased: true,
                        isWritten: true,
                        isExamPostsExists: true)
        } else {
            return Exam(posts: [],
                        isPurchased: false, 
                        isWritten: false,
                        isExamPostsExists: false)
        }
    }
    
    func write(
        id: Int,
        lectureName: String,
        professor: String,
        selectedSemester: String,
        examInfo: String,
        examType: String, 
        examDifficulty: String,
        content: String
    ) async throws -> Bool {
        self.id = id
        return isWriteCalled
    }
    
    func update(
        id: Int,
        selectedSemester: String,
        examInfo: String,
        examType: String,
        examDifficulty: String,
        content: String
    ) async throws -> Bool {
        return isUpdateCalled
    }
    
    func purchase(id: Int) async throws -> Bool {
        return isPurchaseCalled
    }
    
    func fetchUserPosts() async throws -> [UserExamPost] {
        if isFetchUserPostCalled {
            return [UserExamPost(id: 1,
                                 name: "",
                                 professor: "",
                                 major: "",
                                 selectedSemester: "", 
                                 semesterList: "",
                                 examType: "",
                                 sourceOfExam: "",
                                 difficulty: "",
                                 content: "")]
        } else {
            return []
        }
    }
    
    func fetchPurchasedExamPosts() async throws -> [PurchasedPost] {
        if isFetchPurchasedExamPostsCalled {
            return [PurchasedPost(id: 1, name: "", date: "")]
        } else {
            return []
        }
    }
}
