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
        registerViewModels()
        registerViews()
    }

    func registerRepositories() {
        container.register(type: LectureRepository.self,
                           DefaultLectureRepository())
        container.register(type: UserRepository.self,
                           DefaultUserRepository())
        container.register(type: KeychainRepository.self,
                           DefaultKeychainRepository())
        container.register(type: EvaluatePostRepository.self, 
                           DefaultEvaluatePostRepository())
    }

    func registerUseCases() {
        container.register(type: FetchLectureUseCase.self, DefaultFetchLectureUseCase())
        container.register(type: SearchLectureUseCase.self, DefaultSearchLectureUseCase())
        container.register(type: SignInUseCase.self, DefaultSignInUseCase())
        container.register(type: CreateTokenUseCase.self, DefaultCreateTokenUseCase())
        container.register(type: ReadTokenUseCase.self, DefaultReadTokenUseCase())
        container.register(type: FetchDetailLectureUseCase.self, DefaultFetchDetailLectureUseCase())
        container.register(type: FetchEvaluatePostsUseCase.self, DefaultFetchEvaluatePostsUseCase())
    }

    func registerViewModels() {
        container.register(type: LectureEvaluationHomeViewModel.self, LectureEvaluationHomeViewModel())
    }

    func registerViews() {
        container.register(type: LectureEvaluationHomeView.self, LectureEvaluationHomeView())
    }
}
