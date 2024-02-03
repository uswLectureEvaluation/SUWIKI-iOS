//
//  LoginView.swift
//  SUWIKI
//
//  Created by 한지석 on 2/3/24.
//

import SwiftUI

struct LoginView: View {

    @FocusState private var focusField: LoginViewInputType?
    @StateObject var viewModel = LoginViewModel()

    var body: some View {
        VStack {
            title
            ForEach(LoginViewInputType.allCases, id: \.self) { input in
                inputViews(input)
            }
            Spacer()
            buttonViews
            loginButton
        }
    }

    var title: some View {
        Text("로그인")
            .font(.h1)
            .padding(.top, 60)
    }

    func inputViews(
        _ type: LoginViewInputType
    ) -> some View {
        VStack {
            HStack {
                Text(type == .id ? "아이디" : "비밀번호")
                    .font(.c2)
                    .foregroundStyle(focusField == type ?
                                     Color(uiColor: .primaryColor) : Color(uiColor: .gray95))
                Spacer()
            }
            if type == .id {
                HStack {
                    TextField("아이디를 입력하세요.",
                              text: $viewModel.id)
                    .focused($focusField,
                             equals: .id)
                    //TODO: Clear Button
                    Button {
                        print("tlqkf")
                    } label: {
                        Image(systemName: "person")
                    }
                }

            } else {
                HStack {
                    SecureField("비밀번호를 입력하세요",
                                text: $viewModel.password)
                    .focused($focusField,
                             equals: .password)
                    //TODO: Visible Button
                    Button {
                        print("tlqkf")
                    } label: {
                        Image(systemName: "person")
                    }
                }
            }
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(focusField == type ?
                                 Color(uiColor: .primaryColor) : Color(uiColor: .gray95))
                .padding(.top, 4)
        }
        .padding(.top, type == .id ? 26 : 20)
        .padding(.horizontal, 24)
    }

    var buttonViews: some View {
        HStack {
            ForEach(LoginViewButtonType.allCases, id: \.self) { type in
                buttons(type)
            }
        }
    }

    func buttons(
        _ type: LoginViewButtonType
    ) -> some View {
        HStack {
            Button {
                print(type)
            } label: {
                Text(type.title)
                    .font(.b5)
                    .foregroundStyle(Color(uiColor: type == .signIn ? .primaryColor : .gray6A))
            }
            if type != .signIn {
                Rectangle()
                    .frame(width: 1, height: 12)
                    .foregroundStyle(Color(uiColor: .grayF6))
            }
        }
    }

    var loginButton: some View {
        Button {
            /// Login API 붙히기
            print("@LOG login")
        } label: {
            RoundedRectangle(cornerRadius: 15.0)
                .frame(height: 50)
                .overlay {
                    Text("로그인")
                        .font(.h5)
                        .foregroundStyle(Color(uiColor: .white))
                }
        }
        .disabled(viewModel.isButtonDisabled)
        .padding(.horizontal, 24)
        .padding(.top, 16)
        .padding(.bottom, 120)
    }

}

enum LoginViewInputType: CaseIterable {
    case id
    case password
}

enum LoginViewButtonType: CaseIterable {
    case findId
    case findPassword
    case signIn

    var title: String {
        switch self {
        case .findId:
            "아이디 찾기"
        case .findPassword:
            "비밀번호 찾기"
        case .signIn:
            "회원가입"
        }
    }
}

#Preview {
    LoginView()
}
