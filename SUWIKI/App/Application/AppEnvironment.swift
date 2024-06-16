//
//  AppEnvironment.swift
//  SUWIKI
//
//  Created by 한지석 on 1/27/24.
//

import Foundation

import DIContainer
import Domain
import Data

struct AppEnvironment {
  let container = DIContainer.shared
  
  init() {
    container.register(type: CoreDataManagerInterface.self, CoreDataManager())
    dependencyInjection()
  }
  
  func dependencyInjection() {
    registerDataSources()
    registerRepositories()
    registerUseCases()
    registerViewModels()
    registerViews()
  }
  
  func registerDataSources() {
    container.register(type: CoreDataStorage.self, DefaultCoreDataStorage())
    container.register(type: FirebaseStorage.self, DefaultFirebaseStorage())
  }
  
  func registerRepositories() {
    container.register(type: LectureRepository.self, DefaultLectureRepository())
    container.register(type: UserRepository.self, DefaultUserRepository())
    container.register(type: KeychainRepository.self, DefaultKeychainRepository())
    container.register(type: EvaluationPostRepository.self, DefaultEvaluationPostRepository())
    container.register(type: ExamPostRepository.self, DefaultExamPostRepository())
    container.register(type: NoticeRepository.self, DefaultNoticeRepository())
    container.register(type: TimetableRepository.self, DefaultTimetableRepository())
  }
  
  func registerUseCases() {
    /// 강의평가 내려받기
    container.register(type: FetchLectureUseCase.self,
                       DefaultFetchLectureUseCase())
    /// 강의평가 검색
    container.register(type: SearchLectureUseCase.self,
                       DefaultSearchLectureUseCase())
    /// 로그인
    container.register(type: SignInUseCase.self,
                       DefaultSignInUseCase())
    /// 토큰 생성
    container.register(type: CreateTokenUseCase.self,
                       DefaultCreateTokenUseCase())
    /// 토큰 읽기
    container.register(type: ReadTokenUseCase.self,
                       DefaultReadTokenUseCase())
    /// 강의평가 요약 내려받기
    container.register(type: FetchDetailLectureUseCase.self,
                       DefaultFetchDetailLectureUseCase())
    /// 강의평가 상세 내려받기
    container.register(type: FetchEvaluationPostsUseCase.self,
                       DefaultFetchEvaluationPostsUseCase())
    /// 시험정보 상세 내려받기
    container.register(type: FetchExamPostsUseCase.self,
                       DefaultFetchExamPostUseCase())
    /// 강의평가 작성
    container.register(type: WriteEvaluationPostUseCase.self,
                       DefaultWriteEvaluationPostUseCase())
    /// 시험정보 작성
    container.register(type: WriteExamPostUseCase.self,
                       DefaultWriteExamPostUseCase())
    /// 시험정보 구매
    container.register(type: PurchaseExamPostUseCase.self,
                       DefaultPurchaseExamPostUseCase())
    /// 공지사항 내려받기
    container.register(type: FetchAnnouncementUseCase.self,
                       DefaultFetchAnnouncementUseCase())
    /// 공지사항 자세히 보기
    container.register(type: FetchDetailAnnouncementUseCase.self,
                       DefaultFetchDetailAnnouncementUseCase())
    /// 유저 정보 내려받기
    container.register(type: UserInfoUseCase.self,
                       DefaultUserInfoUseCase())
    /// 유저가 작성한 강의평가 내려받기
    container.register(type: FetchUserEvaluationPostsUseCase.self,
                       DefaultFetchUserEvaluationPostUseCase())
    /// 유저가 작성한 시험정보 내려받기
    container.register(type: FetchUserExamPostsUseCase.self,
                       DefaultFetchUserExamPostsUseCase())
    /// 강의평가 수정
    container.register(type: UpdateEvaluationPostUseCase.self,
                       DefaultUpdateEvaluationPostUseCase())
    /// 시험정보 수정
    container.register(type: UpdateExamPostUseCase.self,
                       DefaultUpdateExamPostUseCase())
    /// 비밀번호 변경
    container.register(type: ChangePasswordUseCase.self,
                       DefaultChangePasswordUseCase())
    /// 시험정보 구매 목록
    container.register(type: FetchPurchasedExamPostsUseCase.self,
                       DefaultFetchPurchasedExamPostsUseCase())
    /// 아이디 중복 확인
    container.register(type: CheckDuplicatedIdUseCase.self,
                       DefaultCheckDuplicatedIdUseCase())
    /// 이메일 중복 확인
    container.register(type: CheckDuplicatedEmailUseCase.self,
                       DefaultCheckDuplicatedEmailUseCase())
    /// 회원가입
    container.register(type: SignUpUseCase.self,
                       DefaultSignUpUseCase())
    /// 아이디 찾기
    container.register(type: FindIdUseCase.self,
                       DefaultFindIdUseCase())
    /// 비밀번호 찾기
    container.register(type: FindPasswordUseCase.self,
                       DefaultFindPasswordUseCase())
    /// 회원탈퇴
    container.register(type: WithDrawUseCase.self,
                       DefaultWithDrawUseCase())
    /// 시간표에 강의 저장하기
    container.register(type: SaveCourseUseCase.self,
                       DefaultSaveCourseUseCase())
    /// 시간표 만들기
    container.register(type: SaveTimetableUseCase.self,
                       DefaultSaveTimetableUseCase())
    /// 시간표명 변경하기
    container.register(type: UpdateTimetableTitleUseCase.self,
                       DefaultUpdateTimetableTitleUseCase())
    /// 시간표에 등록된 강의 삭제
    container.register(type: DeleteCourseUseCase.self,
                       DefaultDeleteCourseUseCase())
    /// 시간표 삭제하기
    container.register(type: DeleteTimetableUseCase.self,
                       DefaultDeleteTimeTableUseCase())
    /// 현재 시간표 내려 받기
    container.register(type: FetchTimetableUseCase.self,
                       DefaultFetchTimetableUseCase())
    /// 시간표 전체 내려받기
    container.register(type: FetchTimetableListUseCase.self,
                       DefaultFetchTimetableListUseCase())
    /// 시간표에 등록된 강의 내려받기
    container.register(type: FetchCoursesUseCase.self,
                       DefaultFetchCoursesUseCase())
    /// 개설학과 내려받기
    container.register(type: FetchMajorsUseCase.self,
                       DefaultFetchMajorsUseCase())
    /// 파이어베이스에 있는 강의 내려받기
    container.register(type: FetchFirebaseCourseUseCase.self,
                       DefaultFetchFirebaseCourseUseCase())
    /// 온라인 강의 내려받기
    container.register(type: FetchELearningUseCase.self,
                       DefaultFetchELearningUseCase())
    /// 개설강의 버전 확인
    container.register(type: CheckCourseVersionUseCase.self,
                       DefaultCheckCourseVersionUseCase())
    
  }
  
  func registerViewModels() {
    container.register(type: LectureEvaluationHomeViewModel.self, LectureEvaluationHomeViewModel())
  }
  
  func registerViews() {
    container.register(type: LectureEvaluationHomeView.self, LectureEvaluationHomeView())
  }
}
