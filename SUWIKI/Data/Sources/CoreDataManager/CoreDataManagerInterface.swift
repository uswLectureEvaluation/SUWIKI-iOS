//
//  CoreDataManager.swift
//  Data
//
//  Created by 한지석 on 5/5/24.
//

import Foundation
import CoreData

public protocol CoreDataManagerInterface {
    var context: NSManagedObjectContext { get }
}
