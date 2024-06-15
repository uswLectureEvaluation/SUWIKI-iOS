//
//  LectureOption.swift
//  Domain
//
//  Created by 한지석 on 5/2/24.
//

import Foundation

public enum LectureOption: String, Encodable, CaseIterable {
  case modifiedDate = "modifiedDate"
  case lectureHoneyAvg = "lectureHoneyAvg"
  case lectureSatisfactionAvg = "lectureSatisfactionAvg"
  case lectureLearningAvg = "lectureLearningAvg"
  case lectureTotalAvg = "lectureTotalAvg"
  
  public var description: String {
    switch self {
    case .modifiedDate:
      "최근 올라온 강의"
    case .lectureHoneyAvg:
      "꿀 강의"
    case .lectureSatisfactionAvg:
      "만족도 높은 강의"
    case .lectureLearningAvg:
      "배울게 많은 강의"
    case .lectureTotalAvg:
      "Best 강의"
    }
  }
}
