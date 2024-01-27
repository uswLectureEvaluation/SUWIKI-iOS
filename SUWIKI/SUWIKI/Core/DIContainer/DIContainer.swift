//
//  DIContainer.swift
//  SUWIKI
//
//  Created by 한지석 on 1/27/24.
//

import Foundation

public final class DIContainer {

    // MARK: - 싱글톤
    public static let shared = DIContainer()

    private init() { }

    // MARK: - 서비스, 객체의 인스턴스들을 관리하는 공간
    public var services: [String: Any] = [:]

    // MARK: - 객체를 services에 등록하는 메소드
    public func register<Service>(type: Service.Type, _ object: Service) {
        services["\(type)"] = object
    }

    // MARK: - 객체를 services에서 리턴해주는 메소드
    public func resolve<Service>(type: Service.Type) -> Service {
        guard let object = services["\(type)"] as? Service else {
            fatalError("@Log - \(type)이 DI 컨테이너에 등록되지 않음.")
        }
        return object
    }
}
