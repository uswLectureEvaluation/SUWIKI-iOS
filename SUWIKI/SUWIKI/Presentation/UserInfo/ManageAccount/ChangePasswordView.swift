//
//  ChangePasswordView.swift
//  SUWIKI
//
//  Created by 한지석 on 4/6/24.
//

import SwiftUI

struct ChangePasswordView: View {

    @FocusState private var focusField: ChangePasswordInputType?
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ChangePasswordViewModel()

    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .ignoresSafeArea()
            VStack {
                /// 1. 현재 비밀번호
                /// 2. 새로운 비밀번호
                /// 3. 새로운 비밀번호 확인
                inputViews(.currentPassword, 
                           $viewModel.currentPassword,
                           $viewModel.isCurrentPasswordVisible)
                newPasswordInput(.newPassword,
                                 $viewModel.newPassword,
                                 $viewModel.isPasswordVaild,
                                 $viewModel.isNewPasswordVisible)
                newPasswordInput(.checkPassword, 
                                 $viewModel.checkPassword,
                                 $viewModel.isPasswordMatched,
                                 $viewModel.isCheckPasswordVisible)
                Spacer()
                loginButton
            }
        }

        .navigationTitle("비밀번호 변경")
        .alert("비밀번호가 일치하지 않습니다.", isPresented: $viewModel.isWrongCurrentPassword) {
            Button("확인") { }
        } message: {
            Text("현재 비밀번호를 확인해주세요.")
        }
    }

    func inputViews(
        _ type: ChangePasswordInputType,
        _ password: Binding<String>,
        _ visible: Binding<Bool>
    ) -> some View {
        VStack {
            HStack {
                Text(type.title)
                    .font(.c2)
                    .foregroundStyle(focusField == type ?
                                     Color(uiColor: .primaryColor) : Color(uiColor: .gray95))
                Spacer()
            }
            HStack {
                if visible.wrappedValue {
                    TextField(type.subtitle, text: password)
                        .focused($focusField, equals: type)
                } else {
                    SecureField("비밀번호를 입력하세요",text: password)
                        .focused($focusField, equals: type)
                }
                if focusField == type {
                    Button {
                        visible.wrappedValue.toggle()
                    } label: {
                        Image(systemName: visible.wrappedValue ? "lock" : "lock.slash")
                            .foregroundStyle(Color(uiColor: .gray95))
                            .frame(width: 18, height: 18)
                    }
                }
                if focusField == type {
                    Button {
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .foregroundStyle(Color(uiColor: .gray95))
                            .frame(width: 18, height: 18)
                    }
                }
            }
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(focusField == type ?
                                 Color(uiColor: .primaryColor) : Color(uiColor: .gray95))
                .padding(.top, 4)
        }
        .padding(.top, 30)
        .padding(.bottom, 20)
        .padding(.horizontal, 24)
    }

    func newPasswordInput(
        _ type: ChangePasswordInputType,
        _ password: Binding<String>,
        _ isVaild: Binding<Bool>,
        _ visible: Binding<Bool>
    ) -> some View {
        VStack {
            HStack {
                Text(type.title)
                    .font(.c2)
                    .foregroundStyle(focusField == type ?
                                     (isVaild.wrappedValue ?
                                      Color(uiColor: .primaryColor) : Color(uiColor: .red))
                                     : Color(uiColor: .gray95))
                Spacer()
            }
            HStack {
                if visible.wrappedValue {
                    TextField(type.subtitle, text: password)
                        .focused($focusField, equals: type)
                } else {
                    SecureField("비밀번호를 입력하세요",text: password)
                        .focused($focusField, equals: type)
                }
                if focusField == type {
                    Button {
                        visible.wrappedValue.toggle()
                    } label: {
                        Image(systemName: visible.wrappedValue ? "lock" : "lock.slash")
                            .foregroundStyle(Color(uiColor: .gray95))
                            .frame(width: 18, height: 18)
                    }
                }
                if focusField == type {
                    Button {
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .foregroundStyle(Color(uiColor: .gray95))
                            .frame(width: 18, height: 18)
                    }
                }
            }
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(focusField == type ?
                                 (isVaild.wrappedValue ?
                                  Color(uiColor: .primaryColor) : Color(uiColor: .red))
                                 : Color(uiColor: .gray95))
                .padding(.top, 4)
            HStack {
                Text(focusField == type && !isVaild.wrappedValue ? type.warning : "")
                    .font(.c2)
                    .foregroundStyle(Color.red)
                    .frame(height: 18)
                Spacer()
            }
        }
        .padding(.horizontal, 24)
    }

    var loginButton: some View {
        Button {
            Task {
                if try await viewModel.changePassword() {
                    dismiss()
                } else {
                    viewModel.isWrongCurrentPassword.toggle()
                }
            }
        } label: {
            RoundedRectangle(cornerRadius: 15.0)
                .frame(height: 50)
                .overlay {
                    Text("비밀번호 변경")
                        .font(.h5)
                        .foregroundStyle(Color(uiColor: .white))
                }
        }
        .disabled(!viewModel.isButtonEnabled)
        .padding(.horizontal, 24)
        .padding(.bottom, 24)
    }

}

#Preview {
    ChangePasswordView()
}

enum ChangePasswordInputType: CaseIterable {
    case currentPassword
    case newPassword
    case checkPassword

    var title: String {
        switch self {
        case .currentPassword:
            "현재 비밀번호"
        case .newPassword:
            "새로운 비밀번호"
        case .checkPassword:
            "새로운 비밀번호 확인"
        }
    }

    var subtitle: String {
        switch self {
        case .currentPassword:
            "현재 비밀번호를 입력하세요"
        case .newPassword:
            "8~20자 영문, 숫자, 특수문자 조합"
        case .checkPassword:
            "새로운 비밀번호를 입력하세요"
        }
    }

    var warning: String {
        switch self {
        case .currentPassword:
            ""
        case .newPassword:
            "8~20자 영문, 숫자, 특수문자를 조합하세요."
        case .checkPassword:
            "비밀번호가 일치하지 않습니다."
        }
    }
}
