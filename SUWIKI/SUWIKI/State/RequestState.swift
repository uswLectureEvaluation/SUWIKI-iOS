//
//  RequestState.swift
//  SUWIKI
//
//  Created by 한지석 on 3/3/24.
//

import Foundation

enum RequestState: CustomState {
    case notRequest
    case isProgress
    case success
    case failed(Error)
}

extension RequestState {
    static func == (lhs: RequestState, rhs: RequestState) -> Bool {
        switch (lhs, rhs) {
        case (.notRequest, .notRequest),
            (.isProgress, .isProgress),
            (.success, .success),
            (.failed, .failed):
            return true
        default:
            return false
        }
    }
}
