//
//  InitAppViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/14.
//

import Foundation

import Firebase
import CoreData

class InitAppViewModel {
    
    let coreDataManager = CoreDataManager.shared
    private let ref = Database.database().reference()
    
    func fetchFirebaseCourse() async -> [FetchCourse] {
        do {
            var fetchCourse: [FetchCourse] = []
            let data = try await ref.getData()
            let value = snapshotToDictionary(snapshot: data)
            for child in data.children {
                let childSnapshot = child as? DataSnapshot
                guard let value = childSnapshot?.value as? NSDictionary else {
                    return fetchCourse
                }
                let course = FetchCourse(classNum: value["classNum"] as? Int ?? 0,
                                         classification: value["classification"] as? String ?? "",
                                         courseDay: value["courseDay"] as? String ?? "",
                                         courseName: value["courseName"] as? String ?? "무제",
                                         credit: value["credit"] as? Int ?? 0,
                                         startTime: value["startTime"] as? String ?? "",
                                         endTime: value["endTime"] as? String ?? "",
                                         major: value["major"] as? String ?? "",
                                         num: value["num"] as? Int ?? 0,
                                         professor: value["professor"] as? String ?? "",
                                         roomName: value["roomName"] as? String ?? "")
                fetchCourse.append(course)
            }
            return fetchCourse
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func snapshotToDictionary(snapshot: DataSnapshot) -> [[String: Any]] {
        guard let value = snapshot.value as? [[String: Any]] else {
            return []
        }
        return value
    }
    
    func saveFirebaseCourse(course: [FetchCourse]) async {
        do {
            try await coreDataManager.saveFirebaseCourse(course: course)
        } catch {
            coreDataManager.handleCoreDataError(error)
        }
    }
    
    
    //        ref.getData { error, data in
    //            var fetchCourse: [FetchCourse] = []
    //            guard let snapshot = data else { return }
    //            for child in snapshot.children {
    //                let childSnapshot = child as? DataSnapshot
    //                guard let value = childSnapshot?.value as? NSDictionary else {
    //                    completionHandler(nil)
    //                    return
    //                }
//                    let course = FetchCourse(classNum: value["classNum"] as? Int ?? 0,
//                                             classification: value["classification"] as? String ?? "",
//                                             courseDay: value["courseDay"] as? String ?? "",
//                                             courseName: value["courseName"] as? String ?? "무제",
//                                             credit: value["credit"] as? Int ?? 0,
//                                             startTime: value["startTime"] as? String ?? "",
//                                             endTime: value["endTime"] as? String ?? "",
//                                             major: value["major"] as? String ?? "",
//                                             num: value["num"] as? Int ?? 0,
//                                             professor: value["professor"] as? String ?? "",
//                                             roomName: value["roomName"] as? String ?? "")
    //                fetchCourse.append(course)
    //            }
    //            completionHandler(fetchCourse)
    //        }
    
    //    func fetchFirebaseCourse() async -> [FetchCourse]? {
    //        return await withUnsafeContinuation { continuation in
    //            ref.getData { error, data in
    //                var fetchCourse: [FetchCourse] = []
    //                guard let snapshot = data else {
    //                    continuation.resume(returning: nil)
    //                    return
    //                }
    //                for child in snapshot.children {
    //                    let childSnapshot = child as? DataSnapshot
    //                    guard let value = childSnapshot?.value as? NSDictionary else {
    //                        continuation.resume(returning: nil)
    //                        return
    //                    }
    //                    let course = FetchCourse(classNum: value["classNum"] as? Int ?? 0,
    //                                             classification: value["classification"] as? String ?? "",
    //                                             courseDay: value["courseDay"] as? String ?? "",
    //                                             courseName: value["courseName"] as? String ?? "무제",
    //                                             credit: value["credit"] as? Int ?? 0,
    //                                             startTime: value["startTime"] as? String ?? "",
    //                                             endTime: value["endTime"] as? String ?? "",
    //                                             major: value["major"] as? String ?? "",
    //                                             num: value["num"] as? Int ?? 0,
    //                                             professor: value["professor"] as? String ?? "",
    //                                             roomName: value["roomName"] as? String ?? "")
    //                    fetchCourse.append(course)
    //                }
    //                continuation.resume(returning: fetchCourse)
    //            }
    //        }
    //    }
    
    //    func fetchFirebaseCourse(completionHandler: @escaping (([FetchCourse]?) -> ())) {
    //        ref.getData { error, data in
    //            var fetchCourse: [FetchCourse] = []
    //            guard let snapshot = data else { return }
    //            for child in snapshot.children {
    //                let childSnapshot = child as? DataSnapshot
    //                guard let value = childSnapshot?.value as? NSDictionary else {
    //                    completionHandler(nil)
    //                    return
    //                }
    //                let course = FetchCourse(classNum: value["classNum"] as? Int ?? 0,
    //                                         classification: value["classification"] as? String ?? "",
    //                                         courseDay: value["courseDay"] as? String ?? "",
    //                                         courseName: value["courseName"] as? String ?? "무제",
    //                                         credit: value["credit"] as? Int ?? 0,
    //                                         startTime: value["startTime"] as? String ?? "",
    //                                         endTime: value["endTime"] as? String ?? "",
    //                                         major: value["major"] as? String ?? "",
    //                                         num: value["num"] as? Int ?? 0,
    //                                         professor: value["professor"] as? String ?? "",
    //                                         roomName: value["roomName"] as? String ?? "")
    //                fetchCourse.append(course)
    //            }
    //            completionHandler(fetchCourse)
    //        }
    //    }
    
//    func saveCourseToCoreData(course: [FetchCourse]) async { // 데이터 저장하기
//        do {
//            try await coreDataManager.saveFirebaseCourse(course: course)
//        } catch {
//            coreDataManager.handleCoreDataError(error)
//        }
//        checkCoreDataCount()
//    }
    
    func checkCoreDataCount() { // 저장된 데이터 불러오기 - 시간표 추가 시 필요할듯한데..
        var temp: [FirebaseCourse] = []
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        if let loadCourse = try? context.fetch(FirebaseCourse.fetchRequest()) {
            temp = loadCourse
            print(temp.count)
        }
    }
    
}

enum FirebaseError: Error {
    
}
