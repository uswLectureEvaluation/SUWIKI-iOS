//
//  SignUpView.swift
//  SUWIKI
//
//  Created by 한지석 on 4/9/24.
//

import SwiftUI

struct SignUpView: View {

    @FocusState var focusField: SignUpInputType?
    @StateObject var viewModel = SignUpViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .ignoresSafeArea()
            VStack {
                switch viewModel.signUpState {
                case .idAndPassword:
                    idInputView
                    passwordInputViews(.password,
                                       $viewModel.password,
                                       $viewModel.isPasswordVaild,
                                       $viewModel.passwordVisible)
                    passwordInputViews(.checkPassword,
                                       $viewModel.checkPassword,
                                       $viewModel.isPasswordMatched,
                                       $viewModel.checkPasswordVisible)
                    Spacer()
                    nextButton
                case .email:
                    emailInputView
                    Spacer()
                    emailAndBackButton
                case .success:
                    successView
                    Spacer()
                    successButtons
                }
            }
        }
        .animation(.smooth, value: viewModel.signUpState)
        .navigationTitle(viewModel.signUpState.title)
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    SignUpView()
}
