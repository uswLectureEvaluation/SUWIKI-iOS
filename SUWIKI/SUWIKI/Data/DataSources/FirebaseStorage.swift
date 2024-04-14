//
//  FirebaseStorage.swift
//  SUWIKI
//
//  Created by 한지석 on 4/14/24.
//

import Foundation

import FirebaseDatabase

protocol FirebaseStorage {
    func fetchCourse() async throws
    func isVersionChanged() async throws
}

extension FirebaseStorage {
    func snapshotToDictionary(snapshot: DataSnapshot) -> [[String: Any]] {
        guard let value = snapshot.value as? [[String: Any]] else {
            return []
        }
        var dictionaries: [[String: Any]] = []
        let notUpdatedCourseName = "시간표가 업데이트 되지 않았어요."
        let notUpdatedCourseInfo = "미정"
        let notUpdatedCourseTime = "22:00"
        for fetchCourse in value {
            var courseDictionary: [String: Any] = [:]
            courseDictionary["classNum"] = fetchCourse["classNum"] as? String ?? notUpdatedCourseInfo
            courseDictionary["classification"] = fetchCourse["classification"] as? String ?? notUpdatedCourseInfo
            courseDictionary["courseDay"] = fetchCourse["courseDay"] as? String ?? notUpdatedCourseInfo
            courseDictionary["courseName"] = fetchCourse["courseName"] as? String ?? notUpdatedCourseName
            courseDictionary["credit"] = fetchCourse["credit"] as? Int ?? 0
            courseDictionary["startTime"] = fetchCourse["startTime"] as? String ?? notUpdatedCourseTime
            courseDictionary["endTime"] = fetchCourse["endTime"] as? String ?? notUpdatedCourseTime
            courseDictionary["major"] = fetchCourse["major"] as? String ?? notUpdatedCourseInfo
            courseDictionary["num"] = fetchCourse["num"] as? Int ?? 0
            courseDictionary["professor"] = fetchCourse["professor"] as? String ?? notUpdatedCourseInfo
            courseDictionary["roomName"] = fetchCourse["roomName"] as? String ?? notUpdatedCourseInfo
            dictionaries.append(courseDictionary)
        }
        return dictionaries
    }
}
