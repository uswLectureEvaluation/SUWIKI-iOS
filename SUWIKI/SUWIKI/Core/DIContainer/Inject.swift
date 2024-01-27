//
//  Inject.swift
//  SUWIKI
//
//  Created by 한지석 on 1/27/24.
//

import Foundation

// MARK: - Inject, 추상화를 의존하는 경우에 이니셜라이저를 수정하지 않고 프로퍼티 래퍼로 의존성 주입
@propertyWrapper
public struct Inject<Service> {
    public let wrappedValue: Service

    public init() {
        self.wrappedValue = DIContainer.shared.resolve(type: Service.self)
    }
}
