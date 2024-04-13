//
//  SaveTimetableUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/13/24.
//

import Foundation

protocol SaveTimetableUseCase {
    func execute(name: String, semester: String)
}
