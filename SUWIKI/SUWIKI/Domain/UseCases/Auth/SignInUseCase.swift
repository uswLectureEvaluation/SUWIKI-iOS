//
//  SignInUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 2/4/24.
//

import Foundation

protocol SignInUseCase {
    func excute(
        id: String,
        password: String
    ) -> Bool
}

final class DefaultSignInUseCase: SignInUseCase {

}
