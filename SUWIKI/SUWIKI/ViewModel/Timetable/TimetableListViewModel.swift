//
//  TimetableListViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/08/30.
//

import Foundation

final class TimetableListViewModel {
    
    let timetable: [Timetable] = CoreDataManager.shared.fetchTimetable().reversed()
    var timetableNumberOfRowsInSection: Int {
        return self.timetable.count
    }
    
}
