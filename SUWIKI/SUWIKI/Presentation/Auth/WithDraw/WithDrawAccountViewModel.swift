//
//  WithDrawAccountViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 4/11/24.
//

import Foundation
import Combine

import Domain
import DIContainer
import Keychain

final class WithDrawAccountViewModel: ObservableObject {

    @Inject var useCase: WithDrawUseCase

    @Published var id: String = ""
    @Published var password: String = ""
    @Published var isPasswordVisible = false
    @Published var isButtonEnabled = false
    @Published var isAlertPresented = false
    @Published var isWithDrawSuccess = false
    @Published var isWithDrawFailure = false

    var cancellables = Set<AnyCancellable>()

    init() {
        $id
            .combineLatest($password)
            .receive(on: RunLoop.main)
            .map {
                print($0.count)
                print($1.count)
                return $0.count >= 6 && $0.count < 20 && $1.count >= 8 && $1.count < 20
            }
            .sink { [weak self] bool in
                print(bool)
                guard let self = self else { return }
                self.isButtonEnabled = bool
            }
            .store(in: &cancellables)
    }

    func withDraw() async throws {
        do {
            let value = try await useCase.execute(id: self.id, password: self.password)
            await MainActor.run {
                if value {
                    self.isWithDrawSuccess.toggle()
                } else {
                    self.isWithDrawFailure.toggle()
                }
            }
        } catch {
            await MainActor.run {
                self.isWithDrawFailure.toggle()
            }
        }
    }

    func deleteTokens() {
        KeychainManager.shared.delete(token: .AccessToken)
        KeychainManager.shared.delete(token: .RefreshToken)
    }

}
