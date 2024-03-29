//
//  LoginViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2/3/24.
//

import Foundation
import Combine

final class LoginViewModel: ObservableObject {
    
    var signInUseCase: SignInUseCase = DIContainer.shared.resolve(type: SignInUseCase.self)
    var createTokenUseCase: CreateTokenUseCase = DIContainer.shared.resolve(type: CreateTokenUseCase.self)
    @Published var id: String = "" {
        didSet {
            isInvalid = true
        }
    }
    @Published var password: String = "" {
        didSet {
            isInvalid = true
        }
    }
    @Published var isButtonDisabled = true
    @Published var isInvalid = false
    @Published var isPasswordVisible = false
    var cancellables = Set<AnyCancellable>()
    lazy var vaildLoginButton: AnyPublisher<Bool, Never> = Publishers.CombineLatest($id, $password)
        .map {
            return $0.count < 6 || $0.count > 20 || $1.count < 8 || $1.count > 20
        }
        .removeDuplicates()
        .eraseToAnyPublisher()
    
    init() {
        vaildLoginButton
            .receive(on: RunLoop.main)
            .sink { self.isButtonDisabled = $0 }
            .store(in: &cancellables)
    }

    /// func signIn: signIn Usecase를 실행한 후 리턴받은 토큰을 키체인에 저장합니다.
    /// signInUseCase & createTokenUseCase를 실행합니다.
    /// 로그인에 실패했을 경우 catch문을 통해 isInvalid 프로퍼티를 true, UI 피드백을 진행합니다.
    func signIn() async throws {
        do {
            let signIn = try await signInUseCase.excute(id: self.id, password: self.password)
            createTokenUseCase.excute(token: .AccessToken, value: signIn.accessToken)
            createTokenUseCase.excute(token: .RefreshToken, value: signIn.refreshToken)
        } catch {
            isInvalid = true
            print("에러 캐치")
        }
    }

}
