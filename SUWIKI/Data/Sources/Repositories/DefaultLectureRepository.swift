//
//  DefaultLectureRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 1/25/24.
//

import Foundation

import Domain
import Network

public final class DefaultLectureRepository: LectureRepository {
  
  let apiProvider: APIProviderProtocol
  
  public init(
    apiProvider: APIProviderProtocol
  ) {
    self.apiProvider = apiProvider
  }
  
  public func fetch(
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
    let dtoLecture = try await apiProvider.request(
      DTO.AllLectureResponse.self,
      target: target
    )
    return dtoLecture.lecture.map {
      $0.entity
    }
  }
  
  public func search(
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
    let dtoLecture = try await apiProvider.request(
      DTO.AllLectureResponse.self,
      target: target
    )
    return dtoLecture.lecture.map {
      $0.entity
    }
  }
  
  public func fetchDetail(
    id: Int
  ) async throws -> DetailLecture {
    let target = APITarget.Lecture.detail(
      DTO.DetailLectureRequest(
        lectureId: id
      )
    )
    let dtoDetailLecture = try await apiProvider.request(
      DTO.DecodingDetailLectureResponse.self,
      target: target
    )
    return dtoDetailLecture.detailLecture.entity
  }
}
