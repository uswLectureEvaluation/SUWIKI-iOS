//
//  DefaultLectureRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 1/25/24.
//

import Foundation

import Alamofire

final class DefaultLectureRepository: LectureRepository {

    func load(
        option: LectureOption,
        page: Int,
        major: String?
    ) async throws -> [Lecture] {
        let target = APITarget.Lecture.getHome(DTO.AllLectureRequest(option: option,
                                                                     page: page,
                                                                     majorType: major))
        let dtoLecture = try await APIProvider.request(DTO.AllLectureResponse.self,
                                                       target: target)
        return dtoLecture.lecture.map { $0.entity }
    }

}
