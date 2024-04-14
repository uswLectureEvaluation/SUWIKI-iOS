//
//  FirebaseManager.swift
//  SUWIKI
//
//  Created by 한지석 on 12/21/23.
//

import Foundation

import Firebase
import FirebaseDatabase

class FirebaseManager {

    static let shared = FirebaseManager()
    let ref = Database.database().reference()
    init () { }
}

enum FirebaseError: Error {
    case fetchError
}
