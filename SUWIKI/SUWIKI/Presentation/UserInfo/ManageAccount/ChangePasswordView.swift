//
//  ChangePasswordView.swift
//  SUWIKI
//
//  Created by 한지석 on 4/6/24.
//

import SwiftUI

struct ChangePasswordView: View {

    @FocusState private var focusField: ChangePasswordInputType?
    @State var currentPassword: String = ""
    @State var newPassword: String = ""
    @State var checkPassword: String = ""

    var body: some View {
        VStack {
            inputViews(.currentPassword)
            inputViews(.newPassword)
            inputViews(.checkPassword)
        }
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }

    func inputViews(
        _ type: ChangePasswordInputType
    ) -> some View {
        VStack {
            HStack {
                /// 1. 현재 비밀번호
                /// 2. 새로운 비밀번호
                /// 3. 새로운 비밀번호 확인
                Text(type == .newPassword ? "아이디" : "비밀번호")
                    .font(.c2)
                //                    .foregroundStyle(focusField == type ?
                //                                     Color(uiColor: .primaryColor) : Color(uiColor: .gray95))
                Spacer()
            }
            if type == .currentPassword {
                HStack {
                    TextField("아이디를 입력하세요.", text: $currentPassword)
                        .focused($focusField, equals: .currentPassword)
                    if focusField == type {
                        Button {
                            //                            viewModel.id = ""
                        } label: {
                            Image(systemName: "x.circle.fill")
                                .foregroundStyle(Color(uiColor: .gray95))
                                .frame(width: 18, height: 18)
                        }
                    }
                }
            } else {
                HStack {
                    TextField("비밀번호를 입력하세요.", text: $newPassword)
                        .focused($focusField, equals: .newPassword)
                    //                    if viewModel.isPasswordVisible {
                    //                    TextField("비밀번호를 입력하세요.", text: $viewModel.password)
                    //                        .focused($focusField, equals: .password)
                    //                    } else {
                    //                        SecureField("비밀번호를 입력하세요",text: $viewModel.password)
                    //                            .focused($focusField, equals: .password)
                    //                    }
                    //                    if focusField == type {
                    //                        Button {
                    //                            viewModel.isPasswordVisible.toggle()
                    //                        } label: {
                    //                            Image(systemName: viewModel.isPasswordVisible ? "lock" : "lock.slash")
                    //                                .foregroundStyle(Color(uiColor: .gray95))
                    //                                .frame(width: 18, height: 18)
                    //                        }
                    //                    }
                }
            }
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(focusField == type ?
                                 Color(uiColor: .primaryColor) : Color(uiColor: .gray95))
                .padding(.top, 4)
        }
        .padding(.top, type == .currentPassword ? 26 : 20)
        .padding(.horizontal, 24)
    }
}

#Preview {
    ChangePasswordView()
}

enum ChangePasswordInputType: CaseIterable {
    case currentPassword
    case newPassword
    case checkPassword
}
