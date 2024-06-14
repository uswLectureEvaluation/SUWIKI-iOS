//
//  EmailInputView.swift
//  SUWIKI
//
//  Created by 한지석 on 4/10/24.
//

import SwiftUI

extension SignUpView {
  @ViewBuilder
  var emailInputView: some View {
    VStack {
      HStack {
        Text(SignUpInputType.email.title)
          .font(.c2)
          .foregroundStyle(focusField == .email ?
                           (viewModel.isEmailAvailabled ? Color(uiColor: .primaryColor) : Color(uiColor: .red))
                           : Color(uiColor: .gray95))
        Spacer()
      }
      HStack {
        TextField(SignUpInputType.email.subtitle, text: $viewModel.email)
          .focused($focusField, equals: .email)
        if focusField == .email {
          Button {
          } label: {
            Image(systemName: "x.circle.fill")
              .foregroundStyle(Color(uiColor: .gray95))
              .frame(width: 18, height: 18)
          }
          .padding(.bottom, 2)
        }
      }
      Rectangle()
        .frame(height: 1)
        .foregroundStyle(focusField == .email ?
                         (viewModel.isEmailAvailabled ? Color(uiColor: .primaryColor) : Color(uiColor: .red))
                         : Color(uiColor: .gray95))
        .padding(.top, 4)
      if focusField == .email {
        HStack {
          Text(viewModel.isEmailVaild ?
               (viewModel.isEmailAvailabled ? "" : "중복된 이메일입니다.")
               : SignUpInputType.email.warning)
          .font(.c4)
          .foregroundStyle(Color.red)
          .frame(height: 18)
          Spacer()
        }
        .frame(height: 18)
      }

      HStack {
        Text("웹메일이 휴먼 상태인지 확인해주세요.")
          .font(.b5)
          .foregroundStyle(Color(uiColor: .primaryColor))
        Spacer()
      }
      .padding(.top, 4)
      HStack {
        Text("웹메일 계정은 포털 계정과 다릅니다.")
          .font(.b5)
          .foregroundStyle(Color(uiColor: .primaryColor))
        Spacer()
      }
    }
    .padding(.top, 30)
    .padding(.horizontal, 24)
  }

  var emailAndBackButton: some View {
    HStack {
      Button {
        viewModel.signUpStateChange()
      } label: {
        RoundedRectangle(cornerRadius: 15.0)
          .foregroundStyle(Color.white)
          .frame(height: 50)
          .overlay {
            Text("이전")
              .font(.h5)
              .foregroundStyle(Color(uiColor: .primaryColor))
          }
          .overlay {
            RoundedRectangle(cornerRadius: 15)
              .stroke(Color(uiColor: .primaryColor),
                      lineWidth: 1)
          }
      }
      Button {
        Task {
          try await viewModel.signUp()
        }
      } label: {
        RoundedRectangle(cornerRadius: 15.0)
          .frame(height: 50)
          .overlay {
            Text("인증메일 전송")
              .font(.h5)
              .foregroundStyle(Color(uiColor: .white))
          }
      }
      .disabled(!viewModel.isEmailAvailabled)
    }
    .padding(.horizontal, 24)
    .padding(.bottom, 24)
  }
}
