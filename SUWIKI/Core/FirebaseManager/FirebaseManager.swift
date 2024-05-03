//
//  FirebaseManager.swift
//
//
//  Created by 한지석 on 4/16/24.
//

import Foundation

import Firebase
import FirebaseDatabase
import FirebaseRemoteConfig

@available(iOS 13.0.0, *)
public class FirebaseManager {
    public static let shared = FirebaseManager()
    public let ref = Database.database().reference()
    public init () { }

    public func fetchCourse() async throws -> [[String: Any]] {
        do {
            let data = try await self.ref.getData()
            let course = snapshotToDictionary(snapshot: data)
            return course
        } catch {
            print("@Log - \(error.localizedDescription)")
            return []
        }
    }

    public func isVersionChanged(completionHandler: @escaping (Bool) -> ()) async throws {
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        let fetch = try await remoteConfig.fetch()
        if fetch == .success {
            let activate = try await remoteConfig.activate()
            if activate {
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }
    }
}

@available(iOS 13.0.0, *)
extension FirebaseManager {
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

enum FirebaseError: Error {
    case fetchError
}
