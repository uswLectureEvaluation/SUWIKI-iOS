//
//  ServiceType.swift
//  SUWIKI
//
//  Created by 한지석 on 4/3/24.
//

import Foundation

enum ServiceType: CaseIterable {
    case feedback
    case termsOfService
    case privacyPolicy

    var title: String {
        switch self {
        case .feedback:
            "피드백 전송"
        case .termsOfService:
            "이용약관"
        case .privacyPolicy:
            "개인정보 처리 방침"
        }
    }

    var url: URL {
        switch self {
        case .feedback:
            URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSepxjMAp4KKzQGZ0MFOWnI6CjfXSfi20VPGffXMfxzcMQyBhQ/viewform")!
        case .termsOfService:
            URL(string: "https://sites.google.com/view/suwiki-policy-terms")!
        case .privacyPolicy:
            URL(string: "https://sites.google.com/view/suwiki-policy-privacy")!
        }
    }
}
