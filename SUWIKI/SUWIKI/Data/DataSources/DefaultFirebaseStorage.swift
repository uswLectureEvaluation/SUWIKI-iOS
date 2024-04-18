//
//  DefaultFirebaseStorage.swift
//  SUWIKI
//
//  Created by 한지석 on 4/14/24.
//

import Foundation

import DIContainer
import FirebaseManager

import Firebase
import FirebaseDatabase
import FirebaseRemoteConfig

final class DefaultFirebaseStorage: FirebaseStorage {

    @Inject var coreDataStorage: CoreDataStorage
    let firebaseManager = FirebaseManager.shared

    func fetchCourse() async throws {
        do {
            let data = try await firebaseManager.ref.getData()
            let course = snapshotToDictionary(snapshot: data)
            try coreDataStorage.saveFirebaseCourse(course: course)
        } catch {
            print("@Log - \(error.localizedDescription)")
        }
    }
    
    func isVersionChanged() async throws {
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        let fetch = try await remoteConfig.fetch()
        if fetch == .success {
            let activate = try await remoteConfig.activate()
            if activate {
                try await fetchCourse()
            }
        }
    }
    

}
