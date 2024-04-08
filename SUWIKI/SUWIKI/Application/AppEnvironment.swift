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
        container.register(type: EvaluationPostRepository.self,
                           DefaultEvaluationPostRepository())
        container.register(type: ExamPostRepository.self,
                           DefaultExamPostRepository())
        container.register(type: NoticeRepository.self,
                           DefaultNoticeRepository())
    }

    func registerUseCases() {
        /// 강의평가 내려받기
        container.register(type: FetchLectureUseCase.self, DefaultFetchLectureUseCase())
        /// 강의평가 검색
        container.register(type: SearchLectureUseCase.self, DefaultSearchLectureUseCase())
        /// 회원가입
//        container.register(type: SignInUseCase.self, DefaultSignInUseCase())
        /// 토큰 생성
        container.register(type: CreateTokenUseCase.self, DefaultCreateTokenUseCase())
        /// 토큰 읽기
        container.register(type: ReadTokenUseCase.self, DefaultReadTokenUseCase())
        /// 강의평가 요약 내려받기
        container.register(type: FetchDetailLectureUseCase.self, DefaultFetchDetailLectureUseCase())
        /// 강의평가 상세 내려받기
        container.register(type: FetchEvaluationPostsUseCase.self, DefaultFetchEvaluationPostsUseCase())
        /// 시험정보 상세 내려받기
        container.register(type: FetchExamPostsUseCase.self, DefaultFetchExamPostUseCase())
        /// 강의평가 작성
        container.register(type: WriteEvaluationPostUseCase.self, DefaultWriteEvaluationPostUseCase())
        /// 시험정보 작성
        container.register(type: WriteExamPostUseCase.self,DefaultWriteExamPostUseCase())
        /// 시험정보 구매
        container.register(type: PurchaseExamPostUseCase.self, DefaultPurchaseExamPostUseCase())
        /// 공지사항 내려받기
        container.register(type: FetchAnnouncementUseCase.self, DefaultFetchAnnouncementUseCase())
        /// 공지사항 자세히 보기
        container.register(type: FetchDetailAnnouncementUseCase.self, DefaultFetchDetailAnnouncementUseCase())
        /// 유저 정보 내려받기
        container.register(type: UserInfoUseCase.self, DefaultUserInfoUseCase())
        /// 유저가 작성한 강의평가 내려받기
        container.register(type: FetchUserEvaluationPostsUseCase.self, DefaultFetchUserEvaluationPostUseCase())
        /// 유저가 작성한 시험정보 내려받기
        container.register(type: FetchUserExamPostsUseCase.self, DefaultFetchUserExamPostsUseCase())
        /// 강의평가 수정
        container.register(type: UpdateEvaluationPostUseCase.self, DefaultUpdateEvaluationPostUseCase())
        /// 시험정보 수정
        container.register(type: UpdateExamPostUseCase.self, DefaultUpdateExamPostUseCase())
        /// 비밀번호 변경
        container.register(type: ChangePasswordUseCase.self, DefaultChangePasswordUseCase())
        /// 시험정보 구매 목록
        container.register(type: FetchPurchasedExamPostsUseCase.self, DefaultFetchPurchasedExamPostsUseCase())
    }

    func registerViewModels() {
        container.register(type: LectureEvaluationHomeViewModel.self, LectureEvaluationHomeViewModel())
    }

    func registerViews() {
        container.register(type: LectureEvaluationHomeView.self, LectureEvaluationHomeView())
    }
}
