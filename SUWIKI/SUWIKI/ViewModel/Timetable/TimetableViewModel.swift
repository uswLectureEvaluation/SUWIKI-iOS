//
//  TimeTableViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/13.
//

import Foundation

import Combine
import Elliotable
import FirebaseRemoteConfig

final class TimetableViewModel {
    
    let coreDataManager = CoreDataManager.shared
    
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var elliottEvent: [ElliottEvent] = []
    @Published var timetableTitle: String = ""
    @Published var timetableIsEmpty: Bool = false
    @Published var versionChecked: Bool = false

    init() {
        fetchTimetable()
        fetchRemoteConfig()
    }

    func fetchTimetable() {
        let timetable = coreDataManager.fetchTimetableList()
        updateCourse()
        self.timetableIsEmpty = timetable.isEmpty
    }
    
    func addTimetable() {
        coreDataManager.addTimeTable(name: "시간표", semester: calculateSemester())
        updateTimetable()
        updateCourse()
    }
    
    func updateTimetable() {
        guard let id = UserDefaults.shared.value(forKey: "id") as? String,
              let title = coreDataManager.fetchTimetable(id: id)?.name else {
            self.timetableTitle = "시간표"
            self.timetableIsEmpty = true
            return
        }
        self.timetableTitle = title
    }
    
    func updateCourse() {
        guard let id = UserDefaults.shared.value(forKey: "id") as? String else {
            self.timetableIsEmpty = true
            return
        }
        let course = coreDataManager.fetchCourse(id: id) // userdefault.get
        elliottEvent = []
        for i in 0..<course.count {
            let event = ElliottEvent(courseId: course[i].courseId ?? "",
                                     courseName: course[i].courseName ?? "",
                                     roomName: course[i].roomName ?? "",
                                     professor: course[i].professor ?? "",
                                     courseDay: ElliotDay(rawValue: Int(course[i].courseDay)) ?? .monday,
                                     startTime: course[i].startTime ?? "",
                                     endTime: course[i].endTime ?? "",
                                     backgroundColor: .timetableColors[Int(course[i].timetableColor)])
            elliottEvent.append(event)
        }
        self.timetableIsEmpty = false
    }
    
    func deleteCourse(uuid: String) {
        guard let index = elliottEvent.firstIndex(where: { $0.courseId == uuid }),
              let id = UserDefaults.shared.value(forKey: "id") as? String
        else { return }
        elliottEvent.remove(at: index)
        do {
            try coreDataManager.deleteCourse(id: id, courseId: uuid)
        } catch {
            coreDataManager.handleCoreDataError(error)
        }
    }
    
    func calculateSemester() -> String {
        let currentYear = Calendar.current.component(.year, from: Date())
        let currentMonth = Calendar.current.component(.month, from: Date())
        if currentMonth <= 6 {
            return "\(currentYear)년 1학기"
        } else {
            return "\(currentYear)년 2학기"
        }
    }

    func fetchRemoteConfig() {
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.fetch { (status, error) -> Void in
            if status == .success {
                remoteConfig.activate { changed, error in
                    if changed {
                        Task {
                            await FirebaseManager.shared.fetchFirebaseCourse()
                            self.versionChecked = true
                            print("@Log - 시간표 최초 업데이트 ~")
                        }
                    } else {
                        self.versionChecked = true
                        print("@Log - 기존 시간표로 출력 ~")
                    }
                }
            } else {
                print(error?.localizedDescription)
            }
        }
    }

}
