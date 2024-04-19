//
//  ChangePasswordViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 4/8/24.
//

import Foundation
import Combine

import DIContainer

final class ChangePasswordViewModel: ObservableObject {

    @Inject var useCase: ChangePasswordUseCase

    @Published var currentPassword: String = ""
    @Published var newPassword: String = ""
    @Published var checkPassword: String = ""

    @Published var isCurrentPasswordVisible = false
    @Published var isNewPasswordVisible = false
    @Published var isCheckPasswordVisible = false

    @Published var isPasswordVaild = false
    @Published var isPasswordMatched = false
    @Published var isButtonEnabled = false
    @Published var isWrongCurrentPassword = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        binding()
        print(isPasswordMatched)
    }

    func binding() {
        $newPassword
            .combineLatest($checkPassword)
            .receive(on: RunLoop.main)
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .sink { [weak self] newPassword, checkPassword in
                guard let self = self else { return }
                self.isPasswordVaild = newPassword.isPasswordVaild()
                self.updateButtonState()
            }
            .store(in: &cancellables)

        $checkPassword
            .receive(on: RunLoop.main)
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .sink { [weak self] checkPassword in
                guard let self = self, !checkPassword.isEmpty else { return }
                self.isPasswordMatched = self.newPassword == checkPassword
                self.updateButtonState()
            }
            .store(in: &cancellables)
    }

    func changePassword() async throws -> Bool {
        let value = try await useCase.execute(current: currentPassword, new: newPassword)
        return value
    }

    private func updateButtonState() {
        isButtonEnabled = (isPasswordVaild && isPasswordMatched) && (!currentPassword.isEmpty)
    }
}
