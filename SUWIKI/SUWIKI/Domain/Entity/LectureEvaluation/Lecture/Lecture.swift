//
//  Lecture.swift
//  SUWIKI
//
//  Created by 한지석 on 1/25/24.
//

import Foundation

/// 정렬 방식, 학과 카테고라이징은 열거형으로 정의 후 값타입으로 가지고 있어야 할지.
/// 학과는 유저가 스스로 로컬에 저장되는 방식이 더 적합할 것 같음

/// 강의평가 강의
struct Lecture: Identifiable, Equatable, Hashable {
    /// 강의 ID
    let id: Int
    /// 강의명
    let name: String
    /// 전공
    let major: String
    /// 교수명
    let professor: String
    /// 이수구분
    let lectureType: String
    /// 평점
    let lectureTotalAvg: Double
}
