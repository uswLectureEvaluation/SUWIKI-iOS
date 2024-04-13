//
//  SignUpViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 4/9/24.
//

import Foundation
import Combine

final class SignUpViewModel: ObservableObject {

    @Inject var checkDuplicatedIdUseCase: CheckDuplicatedIdUseCase
    @Inject var checkDuplicatedEmailUseCase: CheckDuplicatedEmailUseCase
    @Inject var signUpUseCase: SignUpUseCase

    @Published var id: String = ""
    @Published var password: String = ""
    @Published var checkPassword: String = ""
    @Published var email: String = ""
    @Published var isIdVaild = false
    @Published var isIdAvailabled = false
    @Published var isPasswordVaild = false
    @Published var isPasswordMatched = false
    @Published var isNextButtonEnabled = false
    @Published var isEmailVaild = false
    @Published var isEmailAvailabled = false
    @Published var passwordVisible = false
    @Published var checkPasswordVisible = false
    @Published var isSignUpUnabled = false
    @Published var signUpState: SignUpState = .idAndPassword

    var cancellables = Set<AnyCancellable>()

    init() {
        bind()
    }

    func bind() {
        $id
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .sink { [weak self] id in
                guard let self = self else { return }
                self.isIdVaild = id.isIdVaild()
                if self.isIdVaild {
                    Task {
                        try await self.checkDuplicatedId()
                    }
                }
            }
            .store(in: &cancellables)

        $password
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .sink { [weak self] password in
                guard let self = self else { return }
                self.isPasswordVaild = password.isPasswordVaild()
            }
            .store(in: &cancellables)

        $checkPassword
            .receive(on: RunLoop.main)
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .sink { [weak self] checkPassword in
                guard let self = self, !checkPassword.isEmpty else { return }
                self.isPasswordMatched = self.password == checkPassword
            }
            .store(in: &cancellables)

        $email
            .receive(on: RunLoop.main)
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .sink { [weak self] email in
                guard let self = self, !email.isEmpty else { return }
                self.isEmailVaild = email.isEmailVaild()
                if self.isEmailVaild {
                    Task {
                        try await self.checkDuplicatedEmail()
                    }
                }
            }
            .store(in: &cancellables)

        $isNextButtonEnabled
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                let value = isIdVaild && isIdAvailabled && isPasswordVaild && isPasswordMatched
                self.isNextButtonEnabled = value
            }
            .store(in: &cancellables)
    }

    func signUpStateChange() {
        if signUpState == .email {
            signUpState = .idAndPassword
        } else {
            signUpState = .email
        }
    }

    func checkDuplicatedId() async throws {
        do {
            let value = try await checkDuplicatedIdUseCase.execute(id: self.id)
            await MainActor.run {
                self.isIdAvailabled = !value
            }
        } catch {
            self.isIdAvailabled = false
        }
    }

    func checkDuplicatedEmail() async throws {
        do {
            let value = try await checkDuplicatedEmailUseCase.execute(email: self.email)
            await MainActor.run {
                self.isEmailAvailabled = !value
            }
        } catch {
            self.isEmailAvailabled = false
        }
    }

    func signUp() async throws {
        do {
            let value = try await signUpUseCase.execute(id: self.id, password: self.password, email: self.email)
            if value {
                await MainActor.run {
                    signUpState = .success
                }
            } else {
                await MainActor.run {
                    self.isSignUpUnabled = true
                }
            }
        } catch {
            self.isSignUpUnabled = true
        }
    }
}
