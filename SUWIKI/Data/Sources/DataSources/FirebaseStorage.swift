//
//  FirebaseStorage.swift
//  SUWIKI
//
//  Created by 한지석 on 4/14/24.
//

import Foundation

import FirebaseDatabase

protocol FirebaseStorage {
    func fetchCourse() async throws
    func isVersionChanged() async throws
}

