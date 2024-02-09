//
//  DefaultLectureRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 1/25/24.
//

import Foundation

import Alamofire

final class DefaultLectureRepository: LectureRepository {

    func fetch(
        option: LectureOption,
        page: Int,
        major: String?
    ) async throws -> [Lecture] {
        let target = APITarget.Lecture.getHome(
            DTO.AllLectureRequest(
                option: option,
                page: page,
                majorType: major
            )
        )
        let dtoLecture = try await APIProvider.request(
            DTO.AllLectureResponse.self,
            target: target
        )
        return dtoLecture.lecture.map { $0.entity }
    }

    func search(
        searchText: String,
        option: LectureOption,
        page: Int,
        major: String?
    ) async throws -> [Lecture] {
        let target = APITarget.Lecture.search(
            DTO.SearchLectureRequest(
                searchValue: searchText,
                option: option,
                page: page,
                majorType: major
            )
        )
        let dtoLecture = try await APIProvider.request(
            DTO.AllLectureResponse.self,
            target: target
        )
        return dtoLecture.lecture.map { $0.entity }
    }

    func fetchDetail(
        id: Int
    ) async throws -> DetailLecture {
        let target = APITarget.Lecture.detail(
            DTO.DetailLectureRequest(lectureId: id)
        )
        let dtoDetailLecture = try await APIProvider.request(
            DTO.DecodingDetailLectureResponse.self,
            target: target
        )
        return dtoDetailLecture.detailLecture.entity
    }
}
