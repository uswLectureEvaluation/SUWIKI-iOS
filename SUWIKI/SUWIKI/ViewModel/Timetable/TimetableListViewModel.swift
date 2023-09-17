//
//  TimetableListViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/08/30.
//

import Foundation

final class TimetableListViewModel {
    
    let coreDataManager = CoreDataManager.shared
    @Published var timetable: [Timetable] = CoreDataManager.shared.fetchTimetableList().reversed()
    var timetableNumberOfRowsInSection: Int {
        return self.timetable.count
    }
    var timetableIsEmpty: Bool {
        return self.timetable.isEmpty
    }
    
    func updateTimetable(index: Int) {
        UserDefaults.standard.set(self.timetable[index].id, forKey: "id")
    }
    
    /// TODO
    /// 1. 배열 삭제
    /// 2. 배열 카운트 0 -> dismiss()
    /// 3. CoreData 삭제
    /// 4. if id == timetable.id라면 id 수정
    
    func deleteTimetable(index: Int) {
        let setId = UserDefaults.standard.value(forKey: "id") as? String
        let deleteId = timetable[index].id
        do {
            try coreDataManager.deleteTimetable(id: deleteId ?? "")
        } catch {
            coreDataManager.handleCoreDataError(error)
        }
        self.timetable.remove(at: index)
        if timetable.count == 0 {
            // dismiss()
            UserDefaults.standard.removeObject(forKey: "id")
        } else if setId == deleteId {
            UserDefaults.standard.set(self.timetable.first?.id, forKey: "id")
        }
    }
    
}
