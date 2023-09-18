//
//  TimeTableViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/13.
//

import Foundation

import Combine
import Elliotable

final class TimetableViewModel {
    
    let coreDataManager = CoreDataManager.shared
    
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var elliottEvent: [ElliottEvent] = []
    @Published var timetableTitle: String = ""
    @Published var timetableIsEmpty: Bool = false
    
    init() {
        fetchTimetable()
    }

    func fetchTimetable() {
        let timetable = coreDataManager.fetchTimetableList()
        self.timetableIsEmpty = timetable.isEmpty
    }
    
    func addTimetable() {
        coreDataManager.addTimeTable(name: "시간표", semester: calculateSemester())
        updateTimetable()
        self.timetableIsEmpty = false
    }
    
    func updateTimetable() {
        guard let id = UserDefaults.standard.value(forKey: "id") as? String,
              let title = coreDataManager.fetchTimetable(id: id)?.name else {
            self.timetableTitle = "시간표"
            return
        }
        self.timetableTitle = title
    }
    
    func updateCourse() {
        guard let id = UserDefaults.standard.value(forKey: "id") as? String else {
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
    }
    
    func deleteCourse(uuid: String) {
        guard let index = elliottEvent.firstIndex(where: { $0.courseId == uuid }),
              let id = UserDefaults.standard.value(forKey: "id") as? String
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
    
}

//    func tempIsFinished() {
//        let addController = AddCourseViewController()
//        addController.viewModel.$isFinished
//            .receive(on: DispatchQueue.main)
//            .sink { isFinished in
//                print("@Log sink - \(isFinished)")
//                self.getCourse()
//            }
//            .store(in: &addController.cancellable)
//    }
