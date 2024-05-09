//
//  ExamPostTestsProtocol.swift
//  Domain
//
//  Created by 한지석 on 5/9/24.
//

import Foundation

protocol ExamPostTestsProtocol {
    func testSuccess() async throws
    func testFailure() async throws
}
