//
//  DefaultFirebaseStorage.swift
//  SUWIKI
//
//  Created by 한지석 on 4/14/24.
//

import Foundation

import DIContainer
import FirebaseManager

final class DefaultFirebaseStorage: FirebaseStorage {
    @Inject var coreDataStorage: CoreDataStorage
    let firebaseManager = FirebaseManager.shared

    func fetchCourse() async throws {
        do {
            let course = try await firebaseManager.fetchCourse()
            try coreDataStorage.saveFirebaseCourse(course: course)
        } catch {
            print("@Log - \(error.localizedDescription)")
        }
    }

    func isVersionChanged() async throws {
        try await firebaseManager.isVersionChanged { versionChanged in
            if versionChanged {
                Task {
                    try await self.fetchCourse()
                }
            }
        }
    }

}
