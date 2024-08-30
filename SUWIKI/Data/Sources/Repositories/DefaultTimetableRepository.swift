//
//  DefaultTimetableRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 4/13/24.
//

import Foundation

import DIContainer
import Domain

public final class DefaultTimetableRepository: TimetableRepository {
  
  @Inject var coreDataStorage: CoreDataStorage
  @Inject var firebaseStorage: FirebaseStorage
  
  public init() { }
  
  public func saveTimetable(
    name: String,
    semester: String
  ) -> Result<(), CoreDataError> {
    do {
      try coreDataStorage.saveTimetable(name: name, semester: semester)
      return .success(())
    } catch {
      return .failure(.saveError)
    }
  }
  
  public func saveCourse(
    id: String,
    course: TimetableCourse
  ) -> Result<(), CoreDataError> {
    do {
      try coreDataStorage.saveCourse(id: id, course: course)
      return .success(())
    } catch {
      return .failure(.saveError)
    }
  }
  
  public func updateTimetableTitle(
    id: String,
    title: String
  ) -> Result<(), CoreDataError> {
    do {
      try coreDataStorage.updateTimetableTitle(id: id, title: title)
      return .success(())
    } catch {
      return .failure(.saveError)
    }
  }
  
  public func fetchTimetable(id: String) -> Result<UserTimetable?, CoreDataError> {
    do {
      let userTimetable = try coreDataStorage.fetchTimetable(id: id)
      return .success(userTimetable)
    } catch {
      return .failure(.fetchError)
    }
  }
  
  public func fetchCourses(id: String) -> Result<[TimetableCourse]?, CoreDataError> {
    do {
      let timetableCourse = try coreDataStorage.fetchCourses(id: id)
      return .success(timetableCourse)
    } catch {
      return .failure(.fetchError)
    }
  }
  
  public func fetchFirebaseCourse(major: String) -> Result<[FetchCourse], CoreDataError> {
    do {
      let fetchCourse = try coreDataStorage.fetchFirebaseCourse(major: major)
      return .success(fetchCourse)
    } catch {
      return .failure(.fetchError)
    }
  }
  
  public func fetchMajors() -> Result<[String], CoreDataError> {
    do {
      let fetchMajors = try coreDataStorage.fetchMajors()
      return .success(fetchMajors)
    } catch {
      return .failure(.fetchError)
    }
  }
  
  public func fetchTimetableList() -> Result<[UserTimetable], CoreDataError> {
    do {
      let userTimetable = try coreDataStorage.fetchTimetableList()
      return .success(userTimetable)
    } catch {
      return .failure(.fetchError)
    }
  }
  
  public func fetchELearning(id: String) -> Result<[TimetableCourse], CoreDataError> {
    do {
      let eLearning = try coreDataStorage.fetchELearning(id: id)
      return .success(eLearning)
    } catch {
      return .failure(.fetchError)
    }
  }

  public func fetchCourseCount(major: String) -> Result<Int, CoreDataError> {
    do {
      let count = try coreDataStorage.fetchCourseCount(major: major)
      return .success(count)
    } catch {
      return .failure(.fetchError)
    }
  }

  public func deleteCourse(
    id: String,
    courseId: String
  ) -> Result<(), CoreDataError> {
    do {
      try coreDataStorage.deleteCourse(id: id, courseId: courseId)
      return .success(())
    } catch {
      return .failure(.deleteError)
    }
  }
  
  public func deleteTimetable(id: String) -> Result<(), CoreDataError> {
    do {
      try coreDataStorage.deleteTimetable(id: id)
      return .success(())
    } catch {
      return .failure(.deleteError)
    }
  }
  
  public func checkCourseVersion() async throws -> Result<(), CoreDataError> {
    do {
      try await firebaseStorage.isVersionChanged()
      return .success(())
    } catch {
      return .failure(.contextError)
    }
  }
  
}
