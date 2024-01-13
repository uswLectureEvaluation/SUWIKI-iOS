//
//  FirebaseManager.swift
//  SUWIKI
//
//  Created by 한지석 on 12/21/23.
//

import Foundation

import Firebase
import CoreData
import FirebaseDatabase

class FirebaseManager {

    static let shared = FirebaseManager()
    let coreDataManager = CoreDataManager.shared
    private let ref = Database.database().reference()

    init () { }

    func courseUpdateCheck() {

    }

    func fetchFirebaseCourse() async {
        do {
            let data = try await ref.getData()
            let course = snapshotToDictionary(snapshot: data)
            try coreDataManager.saveFirebaseCourse(course: course)
        } catch {
            print(error.localizedDescription)
        }
    }

    func snapshotToDictionary(snapshot: DataSnapshot) -> [[String: Any]] {
        guard let value = snapshot.value as? [[String: Any]] else {
            return []
        }
        var dictionaries: [[String: Any]] = []
        var notUpdatedCourseName = "시간표가 업데이트 되지 않았어요."
        var notUpdatedCourseInfo = "미정"
        var notUpdatedCourseTime = "22:00"
        for fetchCourse in value {
            var courseDictionary: [String: Any] = [:]
            courseDictionary["classNum"] = fetchCourse["classNum"] as? String ?? notUpdatedCourseInfo
            courseDictionary["classification"] = fetchCourse["classification"] as? String ?? notUpdatedCourseInfo
            courseDictionary["courseDay"] = fetchCourse["courseDay"] as? String ?? notUpdatedCourseInfo
            courseDictionary["courseName"] = fetchCourse["courseName"] as? String ?? notUpdatedCourseName
            courseDictionary["credit"] = fetchCourse["credit"] as? Int ?? notUpdatedCourseInfo
            courseDictionary["startTime"] = fetchCourse["startTime"] as? String ?? notUpdatedCourseTime
            courseDictionary["endTime"] = fetchCourse["endTime"] as? String ?? notUpdatedCourseTime
            courseDictionary["major"] = fetchCourse["major"] as? String ?? notUpdatedCourseInfo
            courseDictionary["num"] = fetchCourse["num"] as? Int ?? notUpdatedCourseInfo
            courseDictionary["professor"] = fetchCourse["professor"] as? String ?? notUpdatedCourseInfo
            courseDictionary["roomName"] = fetchCourse["roomName"] as? String ?? notUpdatedCourseInfo
            dictionaries.append(courseDictionary)
        }
        return dictionaries
    }

}

enum FirebaseError: Error {
    case fetchError
}
