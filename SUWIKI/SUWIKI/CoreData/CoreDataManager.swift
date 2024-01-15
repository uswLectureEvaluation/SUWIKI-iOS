//
//  CoreDataManager.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/13.
//

import UIKit
import CoreData

enum CoreDataError: Error {
    case batchInsertError
    case entityError
    case contextError
    case saveError
    case fetchError
    case deleteError
}

final class CoreDataManager {
    
    // 싱글톤으로 만들기
    static let shared = CoreDataManager()
    private init() {}


    private static let appGroup = "group.sozohoy.suwiki"

    let container: NSPersistentContainer  = {
        guard let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
            fatalError("Shared file container could not be created.")
        }
        let storeURL = url.appending(path: "SuwikiTimetable.sqlite")
        let storeDescription = NSPersistentStoreDescription(url: storeURL)
        let container = NSPersistentContainer(name: "SuwikiTimetable")
        container.persistentStoreDescriptions = [storeDescription]
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            print("Core Data store URL: \(storeDescription.url!)")
        })
        return container
    }()

    // 임시저장소
    lazy var context = container.viewContext
    
    func handleCoreDataError(_ error: Error) {
        switch error {
        case CoreDataError.batchInsertError:
            print("@Log - Core Data BatchInsert Error")
        case CoreDataError.entityError:
            print("@Log - Core Data Entity Error")
        case CoreDataError.contextError:
            print("@Log - Core Data Context Error")
        case CoreDataError.fetchError:
            print("@Log - Core Data Fetch Error")
        case CoreDataError.saveError:
            print("@Log - Core Data Save Error")
        case CoreDataError.deleteError:
            print("@Log - Core Data Delete Error")
        default:
            print("@Log - Other Error: \(error)")
        }
    }

}

