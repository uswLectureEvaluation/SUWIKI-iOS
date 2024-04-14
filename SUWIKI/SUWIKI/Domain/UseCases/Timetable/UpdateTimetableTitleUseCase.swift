//
//  SaveTimetableTitleUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/14/24.
//

import Foundation

protocol UpdateTimetableTitleUseCase {
    func execute(id: String, title: String)
}
