//
//  DTO+AllLectureRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 1/25/24.
//

import Foundation

import Domain

extension DTO {
    public struct AllLectureRequest: Encodable {
        /// 필터링 옵션
        public let option: LectureOption
        /// Fetch Page
        public let page: Int
        /// 학과 필터링, 이후 학과 fetch 기능 구현 후 붙힐 예정
        public let majorType: String?

        public init(
            option: LectureOption,
            page: Int,
            majorType: String?
        ) {
            self.option = option
            self.page = page
            self.majorType = majorType
        }
    }
}

//enum LectureOption: String, Encodable, CaseIterable {
//    case modifiedDate = "modifiedDate"
//    case lectureHoneyAvg = "lectureHoneyAvg"
//    case lectureSatisfactionAvg = "lectureSatisfactionAvg"
//    case lectureLearningAvg = "lectureLearningAvg"
//    case lectureTotalAvg = "lectureTotalAvg"
//
//    var description: String {
//        switch self {
//        case .modifiedDate:
//            "최근 올라온 강의"
//        case .lectureHoneyAvg:
//            "꿀 강의"
//        case .lectureSatisfactionAvg:
//            "만족도 높은 강의"
//        case .lectureLearningAvg:
//            "배울게 많은 강의"
//        case .lectureTotalAvg:
//            "Best 강의"
//        }
//    }
//}
