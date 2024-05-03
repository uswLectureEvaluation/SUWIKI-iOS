//
//  FindIDViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 4/10/24.
//

import Foundation
import Combine

import DIContainer
import Domain

final class FindIdViewModel: ObservableObject {
    
    @Inject var useCase: FindIdUseCase

    @Published var email: String = ""
    @Published var isEmailVaild = false
    @Published var isFindIdSuccess = false
    @Published var isFindIdFailure = false

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
            }
            .store(in: &cancellables)
    }

    func findId() async throws {
        do {
            let value = try await useCase.execute(email: self.email)
            await MainActor.run {
                if value {
                    isFindIdSuccess.toggle()
                } else {
                    isFindIdFailure.toggle()
                }
            }

        } catch {
            await MainActor.run {
                isFindIdFailure.toggle()
            }
        }
    }

}
