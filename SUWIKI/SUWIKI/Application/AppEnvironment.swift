//
//  AppEnvironment.swift
//  SUWIKI
//
//  Created by 한지석 on 1/27/24.
//

import Foundation

struct AppEnvironment {
    let container = DIContainer.shared

    init() {
        dependencyInjection()
    }

    func dependencyInjection() {
        registerRepositories()
        registerUseCases()
    }

    func registerRepositories() {
        container.register(type: LectureRepository.self,
                           DefaultLectureRepository())
        container.register(type: UserRepository.self,
                           DefaultUserRepository())
        container.register(type: KeychainRepository.self,
                           DefaultKeychainRepository())
    }

    func registerUseCases() {
        container.register(type: FetchLectureUseCase.self, DefaultFetchLectureUseCase())
        container.register(type: SearchLectureUseCase.self, DefaultSearchLectureUseCase())
        container.register(type: SignInUseCase.self, DefaultSignInUseCase())
        container.register(type: CreateTokenUseCase.self, DefaultCreateTokenUseCase())
        container.register(type: ReadTokenUseCase.self, DefaultReadTokenUseCase())
    }
}
