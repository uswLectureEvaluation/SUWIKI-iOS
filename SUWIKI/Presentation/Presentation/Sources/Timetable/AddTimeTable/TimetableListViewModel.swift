//
//  TimetableListViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/08/30.
//

import Foundation
import UIKit

import Domain
import DIContainer

final class TimetableListViewModel {

  @Inject var fetchTimetableListUseCase: FetchTimetableListUseCase
  @Inject var deleteTimetableUseCase: DeleteTimetableUseCase

  @Published var timetable: [UserTimetable] = []

  var timetableNumberOfRowsInSection: Int {
    return self.timetable.count
  }
  var timetableIsEmpty: Bool {
    return self.timetable.isEmpty
  }

  init() {
    fetchTimetableList()
  }

  func updateTimetable(index: Int) {
    UserDefaults.shared.set(self.timetable[index].id, forKey: "id")
  }

  func deleteTimetable(index: Int, currentVC: UIViewController) {
    let setId = UserDefaults.shared.value(forKey: "id") as? String
    let deleteId = timetable[index].id
    deleteTimetableUseCase.execute(id: deleteId)
    timetable.remove(at: index)
    if timetable.count == 0 {
      UserDefaults.shared.removeObject(forKey: "id")
      NotificationCenter.default.post(name: Notification.Name("timetableIsEmpty"),
                                      object: nil)
      currentVC.dismiss(animated: true)
    } else if setId == deleteId {
      UserDefaults.shared.set(self.timetable.first?.id, forKey: "id")
    }
  }

  func fetchTimetableList()  {
    self.timetable = fetchTimetableListUseCase.execute()
  }
}
