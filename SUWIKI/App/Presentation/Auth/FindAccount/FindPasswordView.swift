//
//  FindPasswordView.swift
//  SUWIKI
//
//  Created by 한지석 on 4/10/24.
//

import SwiftUI

struct FindPasswordView: View {

    @FocusState var focusField: FindPasswordInputType?
    @StateObject var viewModel = FindPasswordViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .ignoresSafeArea()
            VStack {
                passwordInputViews(.email,
                                   $viewModel.email,
                                   $viewModel.isEmailVaild)
                .padding(.top, 26)
                passwordInputViews(.id,
                                   $viewModel.id,
                                   $viewModel.isIdVaild)
                Spacer()
                findPasswordButton
            }
        }
        .alert("계정을 확인해주세요!", isPresented: $viewModel.isFindPasswordFailure) {
            Button("확인") { }
        } message: {
            Text("해당 계정을 찾을 수 없습니다.")
        }
        .alert("임시 비밀번호가 발송되었습니다.", isPresented: $viewModel.isFindPasswordSuccess) {
            Button("확인") { dismiss() }
        } message: {
            Text("이메일 수신함을 확인해주세요.")
        }
        .navigationTitle("비밀번호 찾기")
        .navigationBarTitleDisplayMode(.large)
    }

    func passwordInputViews(
        _ type: FindPasswordInputType,
        _ text: Binding<String>,
        _ isVaild: Binding<Bool>
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
                TextField(type.subtitle, text: text)
                    .focused($focusField, equals: type)
                if focusField == type {
                    Button {
                        text.wrappedValue = ""
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
                .foregroundStyle(focusField == type ?
                                 (isVaild.wrappedValue ?
                                  Color(uiColor: .primaryColor) : Color(uiColor: .red))
                                 : Color(uiColor: .gray95))
                .padding(.top, 4)
            HStack {
                Text(focusField == type && !isVaild.wrappedValue ? type.warning : "")
                    .font(.c4)
                    .foregroundStyle(Color.red)
                    .frame(height: 18)
                Spacer()
            }
        }
        .padding(.top, 4)
        .padding(.horizontal, 24)
    }

    private var findPasswordButton: some View {
        Button {
            Task {
                try await viewModel.findPassword()
            }
        } label: {
            RoundedRectangle(cornerRadius: 15.0)
                .frame(height: 50)
                .overlay {
                    Text("비밀번호 찾기")
                        .font(.h5)
                        .foregroundStyle(Color(uiColor: .white))
                }
        }
        .disabled(!viewModel.isButtonEnabled)
        .padding(.horizontal, 24)
        .padding(.bottom, 24)
    }
}

enum FindPasswordInputType {
    case email
    case id

    var title: String {
        switch self {
        case .id:
            "아이디"
        case .email:
            "이메일"
        }
    }

    var subtitle: String {
        switch self {
        case .id:
            "6~20자의 영문, 숫자 조합"
        case .email:
            "@suwon.ac.kr"
        }
    }

    var warning: String {
        switch self {
        case .id:
            "6~20자의 영문/숫자 조합의 아이디를 입력해주세요."
        case .email:
            "올바른 형식의 수원대학교 이메일을 입력해주세요."
        }
    }

}


#Preview {
    FindPasswordView()
}
