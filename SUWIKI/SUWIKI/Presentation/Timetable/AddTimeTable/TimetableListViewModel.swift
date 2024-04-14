//
//  TimetableListViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/08/30.
//

import Foundation
import UIKit

final class TimetableListViewModel {
    
    @Inject var fetchTimetableListUseCase: FetchTimetableListUseCase
    @Inject var deleteTimetableUseCase: DeleteTimetableUseCase

    @Published var timetable: [Timetable] = []

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
    
    /// TODO
    /// 1. 배열 삭제
    /// 2. 배열 카운트 0 -> dismiss()
    /// 3. CoreData 삭제
    /// 4. if id == timetable.id라면 id 수정
    /// 5. timetable = [] 면 id 없애고 아니면 first로 id 수정
    
    func deleteTimetable(index: Int, currentVC: UIViewController) async throws {
        let setId = UserDefaults.shared.value(forKey: "id") as? String
        guard let deleteId = timetable[index].id else { return }
        deleteTimetableUseCase.execute(id: deleteId)
        self.timetable.remove(at: index)
        if timetable.count == 0 {
            UserDefaults.shared.removeObject(forKey: "id")
            NotificationCenter.default.post(name: Notification.Name("timetableIsEmpty"),
                                            object: nil)
            await currentVC.dismiss(animated: true)
        } else if setId == deleteId {
            UserDefaults.shared.set(self.timetable.first?.id, forKey: "id")
        }
    }

    func fetchTimetableList()  {
        self.timetable = fetchTimetableListUseCase.execute()
    }
}
