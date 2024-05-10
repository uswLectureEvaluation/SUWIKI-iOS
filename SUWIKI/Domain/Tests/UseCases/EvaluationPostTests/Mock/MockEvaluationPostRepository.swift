//
//  MockEvaluationPostRepository.swift
//  DomainTests
//
//  Created by 한지석 on 5/10/24.
//

import Foundation

import Domain

final class MockEvaluationPostRepository: EvaluationPostRepository {

    var isFetchCalled = false
    var isWriteCalled = false
    var isUpdateCalled = false
    var isFetchUserPostsCalled = false

    var id: Int? = nil

    func fetch(lectureId: Int, page: Int) async throws -> Domain.Evaluation {
        if isFetchCalled {
            self.id = lectureId
            return Evaluation(
                written: true,
                posts: [
                    EvaluationPost(
                        id: 1,
                        selectedSemester: "",
                        totalAvarage: 1,
                        content: ""
                    )
                ]
            )
        } else {
            return Evaluation(
                written: false,
                posts: []
            )
        }
    }

    func write(
        id: Int,
        lectureName: String,
        professor: String,
        selectedSemester: String,
        satisfaction: Double,
        learning: Double,
        honey: Double,
        team: Int,
        difficulty: Int,
        homework: Int,
        content: String
    ) async throws -> Bool {
        if isWriteCalled {
            self.id = id
        }
        return isWriteCalled
    }

    func update(
        id: Int,
        lectureName: String,
        professor: String,
        selectedSemester: String,
        satisfaction: Double,
        learning: Double,
        honey: Double,
        team: Int,
        difficulty: Int,
        homework: Int,
        content: String
    ) async throws -> Bool {
        if isUpdateCalled {
            self.id = id
        }
        return isUpdateCalled
    }

    func fetchUserPosts() async throws -> [Domain.UserEvaluationPost] {
        if isFetchUserPostsCalled {
            return [
                UserEvaluationPost(
                    id: 1,
                    name: "",
                    professor: "",
                    selectedSemester: "",
                    semester: "",
                    lectureTotalAvg: 1,
                    lectureSatisfactionAvg: 1,
                    lectureHoneyAvg: 1,
                    lectureLearningAvg: 1,
                    lectureDifficultyAvg: 1,
                    lectureTeamAvg: 1,
                    lectureHomeworkAvg: 1,
                    content: ""
                )
            ]
        } else {
            return []
        }
    }
}
