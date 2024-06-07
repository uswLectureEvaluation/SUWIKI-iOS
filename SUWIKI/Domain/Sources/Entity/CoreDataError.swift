//
//  CoreDataError.swift
//  Domain
//
//  Created by 한지석 on 5/5/24.
//

import Foundation

public enum CoreDataError: Error {
    case batchInsertError
    case entityError
    case contextError
    case saveError
    case fetchError
    case deleteError
}
