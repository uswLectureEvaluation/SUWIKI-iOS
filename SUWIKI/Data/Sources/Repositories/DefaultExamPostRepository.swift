//
//  DefaultExamRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 3/1/24.
//

import Foundation

import Domain
import Network

public final class DefaultExamPostRepository: ExamPostRepository {

    let apiProvider: APIProviderProtocol

    public init(apiProvider: APIProviderProtocol) {
        self.apiProvider = apiProvider
    }

    public func fetch(id: Int, page: Int) async throws -> Exam {
        let apiTarget = APITarget.ExamPost.fetchExamPosts(
            DTO.FetchExamPostsRequest(
                lectureId: id, page: page
            )
        )
        let dtoExamInfo = try await apiProvider.request(DTO.FetchExamPostsResponse.self, target: apiTarget)
        return Exam(posts: dtoExamInfo.posts.map { $0.entity },
                            isPurchased: dtoExamInfo.canRead,
                            isWritten: dtoExamInfo.written,
                            isExamPostsExists: dtoExamInfo.examDataExist)
    }

    public func write(
        id: Int,
        lectureName: String,
        professor: String,
        selectedSemester: String,
        examInfo: String,
        examType: String,
        examDifficulty: String,
        content: String
    ) async throws -> Bool {
        let apiTarget = APITarget.ExamPost.writeExamPost(
            DTO.WriteExamPostRequest(lectureInfo: DTO.WriteExamPostRequest.LectureInfo(lectureId: id),
                                     post: DTO.WriteExamPostRequest.Post(lectureName: lectureName,
                                                                         professor: professor,
                                                                         selectedSemester: selectedSemester,
                                                                         examInfo: examInfo,
                                                                         examType: examType,
                                                                         examDifficulty: examDifficulty,
                                                                         content: content))
        )
        return try await apiProvider.request(target: apiTarget)
    }

    public func purchase(id: Int) async throws -> Bool {
        let apiTarget = APITarget.ExamPost.purchaseExamPost(
            DTO.PurchaseExamPostRequest(lectureId: id)
        )
        return try await apiProvider.request(target: apiTarget)
    }

    public func fetchUserPosts() async throws -> [UserExamPost] {
        let apiTarget = APITarget.ExamPost.fetchUserExamPosts
        let value = try await apiProvider.request(DTO.FetchUserExamPostsResponse.self, target: apiTarget)
        return value.posts.map { $0.entity }
    }

    public func update(
        id: Int,
        selectedSemester: String,
        examInfo: String,
        examType: String,
        examDifficulty: String,
        content: String
    ) async throws -> Bool {
        let apiTarget = APITarget
            .ExamPost
            .updateExamPost(DTO.UpdateExamPostRequest(lectureInfo: DTO.UpdateExamPostRequest.LectureInfo(examIdx: id),
                                                      post: DTO.UpdateExamPostRequest.Post(selectedSemester: selectedSemester,
                                                                                           examInfo: examInfo,
                                                                                           examType: examType,
                                                                                           examDifficulty: examDifficulty,
                                                                                           content: content)))
        return try await apiProvider.request(target: apiTarget)
    }

    public func fetchPurchasedExamPosts() async throws -> [PurchasedPost] {
        let apiTarget = APITarget.ExamPost.fetchPurchasedExamPosts
        let value = try await apiProvider.request(DTO.FetchPurchasedExamPostsResponse.self,
                                        target: apiTarget)
        return value.posts.map { $0.entity }.reversed()
    }
}
