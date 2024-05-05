//
//  CoreDataManager.swift
//  Data
//
//  Created by 한지석 on 5/5/24.
//

import Foundation
import CoreData

protocol CoreDataManagerInterface {
    var context: NSManagedObjectContext { get }
}
