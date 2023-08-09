//
//  CoreDataManager+Delete.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/07/31.
//

import Foundation
import CoreData

extension CoreDataManager {
    
    func deleteTimetable() {
//        _ completion: @escaping () -> Void
        if let context = context {
//            let delete = context.deletedObjects
            do {
                let course = try context.fetch(Course.fetchRequest())
                for item in course {
                    context.delete(item)
                }
                try context.save()
                print("@Log delete - \(course)")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
