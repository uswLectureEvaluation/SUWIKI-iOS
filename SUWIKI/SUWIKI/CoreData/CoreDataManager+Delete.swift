//
//  CoreDataManager+Delete.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/07/31.
//

import Foundation
import CoreData

extension CoreDataManager {
    
    func deleteCourse(uuid: String) {
        if let context = context {
            do {
                let fetchRequest = Course.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "courseId == %@", uuid)
                let deleteCourse = try context.fetch(fetchRequest)
                print(deleteCourse)
                if let deleteCourse = deleteCourse.first {
                    context.delete(deleteCourse)
                    try context.save()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
