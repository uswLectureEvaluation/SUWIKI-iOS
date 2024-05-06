//
//  DefaultFirebaseStorage.swift
//  SUWIKI
//
//  Created by 한지석 on 4/14/24.
//

import Foundation

import DIContainer
import FirebaseManager

public final class DefaultFirebaseStorage: FirebaseStorage {
    
    @Inject var coreDataStorage: CoreDataStorage
    let firebaseManager = FirebaseManager.shared

    public init() { }

    public func fetchCourse() async throws {
        do {
            let course = try await firebaseManager.fetchCourse()
            try coreDataStorage.saveFirebaseCourse(course: course)
        } catch {
            print("@Log - \(error.localizedDescription)")
        }
    }

    public func isVersionChanged() async throws {
        try await firebaseManager.isVersionChanged { versionChanged in
            if versionChanged {
                Task {
                    try await self.fetchCourse()
                }
            }
        }
    }

}
