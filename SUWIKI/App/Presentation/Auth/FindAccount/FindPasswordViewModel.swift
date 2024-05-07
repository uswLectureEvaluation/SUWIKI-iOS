//
//  FindPasswordViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 4/10/24.
//

import Foundation
import Combine

import Domain
import DIContainer

final class FindPasswordViewModel: ObservableObject {

    @Inject var useCase: FindPasswordUseCase

    @Published var email: String = ""
    @Published var id: String = ""
    @Published var isEmailVaild = false
    @Published var isIdVaild = false
    @Published var isButtonEnabled = false
    @Published var isFindPasswordSuccess = false
    @Published var isFindPasswordFailure = false

    var cancellables = Set<AnyCancellable>()

    init() {
        bind()
    }

    func bind() {
        $email
            .receive(on: RunLoop.main)
            .sink { [weak self] email in
                guard let self = self, !email.isEmpty else { return }
                self.isEmailVaild = email.isEmailVaild()
                if self.isEmailVaild {
                    self.buttonEnabled()
                }
            }
            .store(in: &cancellables)
        $id
            .receive(on: RunLoop.main)
            .sink { [weak self] id in
                guard let self = self, !id.isEmpty else { return }
                self.isIdVaild = id.isIdVaild()
                if self.isIdVaild {
                    self.buttonEnabled()
                }
            }
            .store(in: &cancellables)
    }

    func buttonEnabled() {
        self.isButtonEnabled = self.isIdVaild && self.isEmailVaild
    }

    func findPassword() async throws {
        do {
            let value = try await useCase.execute(id: self.id, email: self.email)
            await MainActor.run {
                if value {
                    self.isFindPasswordSuccess.toggle()
                } else {
                    self.isFindPasswordFailure.toggle()
                }
            }
        } catch {
            await MainActor.run {
                self.isFindPasswordFailure.toggle()
            }
        }
    }
}
