//
//  DefaultTimetableStorage.swift
//  SUWIKI
//
//  Created by 한지석 on 4/13/24.
//

import Foundation
import CoreData

import DIContainer
import Domain

public final class DefaultCoreDataStorage: CoreDataStorage {
  @Inject var coreDataManager: CoreDataManagerInterface
  
  public init() { }
  
  public func saveTimetable(
    name: String,
    semester: String
  ) throws {
    guard let entity = NSEntityDescription.entity(forEntityName: "Timetable", in: coreDataManager.context) else { return }
    let timetableEntity = NSManagedObject(entity: entity, insertInto: coreDataManager.context)
    let id = UUID().uuidString
    timetableEntity.setValue(id, forKey: "id")
    timetableEntity.setValue(name, forKey: "name")
    timetableEntity.setValue(semester, forKey: "semester")
    do {
      try coreDataManager.context.save()
      UserDefaults.shared.set(id, forKey: "id")
    } catch {
      throw CoreDataError.saveError
    }
  }
  
  public func saveFirebaseCourse(course: [[String : Any]]) throws {
    try deleteFirebaseCourse()
    guard let entity = NSEntityDescription.entity(forEntityName: "FirebaseCourse",
                                                  in: coreDataManager.context)
    else {
      throw CoreDataError.entityError
    }
    let batchInsertRequest = NSBatchInsertRequest(entity: entity,
                                                  objects: course)
    if let fetchResult = try? coreDataManager.context.execute(batchInsertRequest),
       let batchInsertResult = fetchResult as? NSBatchDeleteResult,
       let success = batchInsertResult.result as? Bool,
       success {
      return
    } else {
      throw CoreDataError.batchInsertError
    }
  }
  
  /// func saveTimetableCourse: 선택된 시간표에 강의를 저장합니다.
  /// - Parameter id : timetable id
  /// - Parameter course : 추가할 강의
  public func saveCourse(
    id: String,
    course: TimetableCourse
  ) throws {
    let fetchRequest = Timetable.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %@", id)
    do {
      guard let timetable = try coreDataManager.context.fetch(fetchRequest).first else {
        throw CoreDataError.fetchError
      }
      let courseEntity = Course(context: coreDataManager.context)
      courseEntity.courseId = course.courseId
      courseEntity.courseName = course.courseName
      courseEntity.roomName = course.roomName
      courseEntity.courseDay = Int16(course.courseDay)
      courseEntity.professor = course.professor
      courseEntity.startTime = course.startTime
      courseEntity.endTime = course.endTime
      courseEntity.timetableColor = Int16(course.timetableColor)
      timetable.addToCourses(courseEntity)
      try coreDataManager.context.save()
    } catch {
      coreDataManager.context.rollback()
      throw CoreDataError.saveError
    }
  }
  
  public func updateTimetableTitle(
    id: String,
    title: String
  ) throws {
    let fetchRequest = Timetable.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %@", id)
    do {
      guard let timetable = try coreDataManager.context.fetch(fetchRequest).first else {
        throw CoreDataError.fetchError
      }
      timetable.name = title
      try coreDataManager.context.save()
    } catch {
      coreDataManager.context.rollback()
      throw CoreDataError.saveError
    }
  }
  
  /// func fetchTimetable: Core Data에 저장된 Timetable을 fetch합니다.
  public func fetchTimetable(id: String) throws -> Domain.UserTimetable? {
    var savedTimetable: [Timetable] = []
    do {
      let fetchRequest = Timetable.fetchRequest()
      print("@FETCH - \(fetchRequest)")
      fetchRequest.predicate = NSPredicate(format: "id == %@", id)
      print("@FETCH - \(fetchRequest)")
      savedTimetable = try coreDataManager.context.fetch(fetchRequest)
    } catch {
      throw CoreDataError.fetchError
    }
    let timetable: Domain.UserTimetable? = savedTimetable.first.map { timetable in
      var courses: [TimetableCourse]
      if let savedCourses = timetable.courses as? Set<Course> {
        courses = Array(savedCourses).map {
          TimetableCourse(
            courseId: $0.courseId ?? "9999",
            courseName: $0.courseName ?? "무제",
            roomName: $0.roomName ?? "미정",
            professor: $0.professor ?? "미정",
            courseDay: Int($0.courseDay),
            startTime: $0.startTime ?? "09:30",
            endTime: $0.endTime ?? "10:20",
            timetableColor: Int($0.timetableColor)
          )
        }
      } else {
        courses = []
      }
      return Domain.UserTimetable(
        id: timetable.id ?? UUID().uuidString,
        name: timetable.name ?? "시간표",
        semester: timetable.semester ?? "2024-2",
        courses: courses
      )
    }
    return timetable
  }
  
  /// func fetchCourses: Core Data에 저장된 Course를 fetch합니다.
  public func fetchCourses(id: String) throws -> [TimetableCourse]? {
    var courses: [Course] = []
    do {
      let fetchRequest = Timetable.fetchRequest()
      fetchRequest.predicate = NSPredicate(format: "id == %@", id)
      let timetable = try coreDataManager.context.fetch(fetchRequest)
      if let timetableCourses = timetable.first?.courses as? Set<Course> {
        courses = Array(timetableCourses)
      }
    } catch {
      throw CoreDataError.fetchError
    }
    let timetableCourse: [Domain.TimetableCourse] = courses.map {
      TimetableCourse(
        courseId: $0.courseId ?? "9999",
        courseName: $0.courseName ?? "무제",
        roomName: $0.roomName ?? "미정",
        professor: $0.professor ?? "미정",
        courseDay: Int($0.courseDay),
        startTime: $0.startTime ?? "09:30",
        endTime: $0.endTime ?? "10:20",
        timetableColor: Int($0.timetableColor)
      )
    }
    return timetableCourse
  }
  
  /// func fetchFirebaseCourse: 학과 선택 시, 과목을 선택하는 화면에서 firebaseCourse를 내려받습니다.(강의 원본)
  /// - Parameter : major(학과, String)
  /// - return : [FireabaseCourse]
  public func fetchFirebaseCourse(major: String) throws -> [FetchCourse] {
    var course: [FirebaseCourse] = []
    do {
      let fetchRequest = FirebaseCourse.fetchRequest()
      if major != "전체" {
        fetchRequest.predicate = NSPredicate(format: "major == %@", major)
      }
      course = try coreDataManager.context.fetch(fetchRequest)
    } catch {
      throw CoreDataError.fetchError
    }
    let sortedCourse = course.sorted { $0.courseName! < $1.courseName! }
    let fetchCourse = sortedCourse.map {
      FetchCourse(
        classNum: $0.classNum ?? "",
        classification: $0.classification ?? "미정",
        courseDay: $0.courseDay ?? "월",
        courseName: $0.courseName ?? "미정",
        credit: Int($0.credit),
        startTime: $0.startTime ?? "09:30",
        endTime: $0.endTime ?? "10:20",
        major: $0.major ?? "미정",
        num: Int($0.num),
        professor: $0.professor ?? "미정",
        roomName: $0.roomName ?? "미정"
      )
    }
    return fetchCourse
  }
  
  /// func fetchELearningCourse: Core Data에 저장된 강의 중 이러닝을 Fetch합니다.
  /// - Parameter : id(시간표 ID), courseDay(강의 요일)
  public func fetchELearning(id: String) throws -> [TimetableCourse] {
    var course: [Course] = []
    do {
      let fetchRequest = Timetable.fetchRequest()
      fetchRequest.predicate = NSPredicate(format: "id == %@", id)
      guard let timetable = try coreDataManager.context.fetch(fetchRequest).first else {
        throw CoreDataError.fetchError
      }
      if let timetableCourses = timetable.courses as? Set<Course> {
        let filteredCourses = Array(timetableCourses).filter {
          $0.courseDay == 6 }
        course = filteredCourses
      }
    } catch {
      throw CoreDataError.fetchError
    }
    let timetableCourse: [Domain.TimetableCourse] = course.map {
      TimetableCourse(
        courseId: $0.courseId ?? "9999",
        courseName: $0.courseName ?? "무제",
        roomName: $0.roomName ?? "미정",
        professor: $0.professor ?? "미정",
        courseDay: Int($0.courseDay),
        startTime: $0.startTime ?? "09:30",
        endTime: $0.endTime ?? "10:20",
        timetableColor: Int($0.timetableColor)
      )
    }
    return timetableCourse
  }
  
  /// func fetchMajors: 학과를 받아옵니다.
  /// 중복되는 형태를 없애도록 Set으로 구현했습니다.
  public func fetchMajors() throws -> [String] {
    var courses: [FirebaseCourse]
    do {
      let fetchRequest = FirebaseCourse.fetchRequest()
      courses = try coreDataManager.context.fetch(fetchRequest)
      let majors = Array(Set(courses.compactMap {
        $0.major
      })).sorted { $0 < $1 }
      return majors
    } catch {
      throw CoreDataError.fetchError
    }
  }
  
  /// func fetchTimetableList: Core Data에 저장된 Timetable List를 fetch합니다.
  public func fetchTimetableList() throws -> [Domain.UserTimetable] {
    var savedTimetable: [Timetable] = []
    do {
      let fetchRequest = Timetable.fetchRequest()
      savedTimetable = try coreDataManager.context.fetch(fetchRequest)
    } catch {
      throw CoreDataError.fetchError
    }
    let timetable: [Domain.UserTimetable] = savedTimetable.map {
      let id = $0.id ?? UUID().uuidString
      let name = $0.name ?? "시간표"
      let semester = $0.semester ?? "2024-1"
      return Domain.UserTimetable(id: id, name: name, semester: semester, courses: [])
    }
    return timetable.reversed()
  }
  
  public func deleteCourse(
    id: String,
    courseId: String
  ) throws {
    let fetchRequest = Timetable.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %@", id)
    do {
      let timetable = try coreDataManager.context.fetch(fetchRequest)
      guard let courses = timetable.first?.courses as? Set<Course>,
            let removeCourse = courses.first(where: { $0.courseId == courseId }) else {
        throw CoreDataError.fetchError
      }
      timetable.first?.removeFromCourses(removeCourse)
      coreDataManager.context.delete(removeCourse)
      try coreDataManager.context.save()
    } catch {
      throw CoreDataError.deleteError
    }
  }
  
  public func deleteTimetable(id: String) throws {
    let fetchRequest = Timetable.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %@", id)
    do {
      guard let timetable = try coreDataManager.context.fetch(fetchRequest).first else {
        throw CoreDataError.fetchError
      }
      coreDataManager.context.delete(timetable)
      try coreDataManager.context.save()
    } catch {
      throw CoreDataError.deleteError
    }
  }
  
  public func deleteFirebaseCourse() throws {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FirebaseCourse")
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    do {
      try coreDataManager.context.execute(deleteRequest)
      try coreDataManager.context.save()
    } catch {
      coreDataManager.context.rollback()
      throw CoreDataError.deleteError
    }
  }
  
}
