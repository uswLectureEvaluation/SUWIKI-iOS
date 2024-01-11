//
//  FirebaseManager.swift
//  SUWIKI
//
//  Created by 한지석 on 12/21/23.
//

import Foundation

import CoreData
import Firebase
import FirebaseDatabase

class FirebaseManager {

    static let shared = FirebaseManager()
    let coreDataManager = CoreDataManager.shared
    private let ref = Database.database().reference()

    init () { }

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

        for fetchCourse in value {
            var courseDictionary: [String: Any] = [:]
            courseDictionary["classNum"] = fetchCourse["classNum"] as? String ?? ""
            courseDictionary["classification"] = fetchCourse["classification"] as? String ?? ""
            courseDictionary["courseDay"] = fetchCourse["courseDay"] as? String ?? ""
            courseDictionary["courseName"] = fetchCourse["courseName"] as? String ?? "무제"
            courseDictionary["credit"] = fetchCourse["credit"] as? Int ?? 0
            courseDictionary["startTime"] = fetchCourse["startTime"] as? String ?? ""
            courseDictionary["endTime"] = fetchCourse["endTime"] as? String ?? ""
            courseDictionary["major"] = fetchCourse["major"] as? String ?? ""
            courseDictionary["num"] = fetchCourse["num"] as? Int ?? 0
            courseDictionary["professor"] = fetchCourse["professor"] as? String ?? ""
            courseDictionary["roomName"] = fetchCourse["roomName"] as? String ?? ""
            dictionaries.append(courseDictionary)
        }

        return dictionaries
    }

}

enum FirebaseError: Error {
    case fetchError
}
