//
//  MockLectureRepository.swift
//  DomainTests
//
//  Created by 한지석 on 5/9/24.
//

import Foundation

import Domain

final class MockLectureRepository: LectureRepository {

    var isFetchCalled = false
    var isSearchCalled = false
    var isFetchDetailCalled = false

    var lectureOption: LectureOption = .modifiedDate
    var searchText: String = ""
    var id: Int? = nil

    func fetch(
        option: Domain.LectureOption,
        page: Int,
        major: String?
    ) async throws -> [Domain.Lecture] {
        if isFetchCalled {
            self.lectureOption = option
            return [
                Lecture(id: 1,
                        name: "",
                        major: "",
                        professor: "",
                        lectureType: "",
                        lectureTotalAvg: 1)
            ]
        } else {
            return []
        }
    }

    func search(
        searchText: String,
        option: Domain.LectureOption,
        page: Int,
        major: String?
    ) async throws -> [Domain.Lecture] {
        if isSearchCalled {
            self.searchText = searchText
            self.lectureOption = option
            return [
                Lecture(id: 1,
                        name: "",
                        major: "",
                        professor: "",
                        lectureType: "",
                        lectureTotalAvg: 1)
            ]
        } else {
            return []
        }
    }

    func fetchDetail(id: Int) async throws -> Domain.DetailLecture {
        if isFetchDetailCalled {
            self.id = id
            return DetailLecture(id: id,
                                 name: "",
                                 major: "",
                                 professor: "",
                                 semester: "",
                                 lectureType: "",
                                 lectureTotalAvg: 1,
                                 lectureSatisfactionAvg: 1,
                                 lectureHoneyAvg: 1,
                                 lectureLearningAvg: 1,
                                 lectureDifficultyAvg: 1,
                                 lectureTeamAvg: 1,
                                 lectureHomeworkAvg: 1)
        } else {
            return DetailLecture(id: 0,
                                 name: "",
                                 major: "",
                                 professor: "",
                                 semester: "",
                                 lectureType: "",
                                 lectureTotalAvg: 1,
                                 lectureSatisfactionAvg: 1,
                                 lectureHoneyAvg: 1,
                                 lectureLearningAvg: 1,
                                 lectureDifficultyAvg: 1,
                                 lectureTeamAvg: 1,
                                 lectureHomeworkAvg: 1)
        }
    }
}
