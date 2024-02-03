//
//  LoginViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2/3/24.
//

import Foundation
import Combine

/// keychain 저장
/// 로그인 유즈케이스
final class LoginViewModel: ObservableObject {
    
//    var useCase: AuthUseCase = DIContainer.shared.resolve(type: AuthUseCase.self)
    @Published var id: String = ""
    @Published var password: String = ""
    @Published var isButtonDisabled = true
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
    
}

//id == 6, 20
//pwd == 8, 20 영, 숫, 특수문자

