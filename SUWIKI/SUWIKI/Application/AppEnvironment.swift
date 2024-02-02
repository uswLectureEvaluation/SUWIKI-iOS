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

    func registerUseCases() {
        container.register(type: FetchLectureUseCase.self, 
                           DefaultFetchLectureUseCase())
        container.register(type: SearchLectureUseCase.self,
                           DefaultSearchLectureUseCase())
    }

    func registerRepositories() {
        container.register(type: LectureRepository.self,
                           DefaultLectureRepository())
    }
}
