//
//  FirebaseManager.swift
//  
//
//  Created by 한지석 on 4/16/24.
//

import Foundation

import Firebase
import FirebaseDatabase

public class FirebaseManager {
    public static let shared = FirebaseManager()
    public let ref = Database.database().reference()
    public init () { }
}

enum FirebaseError: Error {
    case fetchError
}
