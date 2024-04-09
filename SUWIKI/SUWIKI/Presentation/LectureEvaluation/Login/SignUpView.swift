//
//  SignUpView.swift
//  SUWIKI
//
//  Created by 한지석 on 4/9/24.
//

import SwiftUI

struct SignUpView: View {

    @FocusState private var focusField: SignUpInputType?
    @State var signUpState: SignUpState = .idAndPassword
    @State var text: String = ""
    @State var visible: Bool = false

    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .ignoresSafeArea()
            VStack {
                if signUpState == .idAndPassword {
                    inputViews(.id, $text, $visible)
                    inputViews(.password, $text, $visible)
                    inputViews(.checkPassword, $text, $visible)
                } else {
                    emailInputView(.email, $text)
                }

                Spacer()
                if signUpState == .idAndPassword {
                    nextButton
                } else {
                    emailAndBackButton
                }

            }
        }
        .animation(.smooth, value: signUpState)
        .navigationTitle(signUpState.title)
        .navigationBarTitleDisplayMode(.large)
    }

    func inputViews(
        _ type: SignUpInputType,
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
                if type == .id {
                    TextField(type.subtitle, text: password)
                        .focused($focusField, equals: type)
                } else {
                    if visible.wrappedValue {
                        TextField(type.subtitle, text: password)
                            .focused($focusField, equals: type)
                    } else {
                        SecureField(type.subtitle, text: password)
                            .focused($focusField, equals: type)
                    }
                }
                if focusField == type && type != .id {
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
                    .padding(.bottom, 2)
                }
            }
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(focusField == type ?
                                 Color(uiColor: .primaryColor) : Color(uiColor: .gray95))
                .padding(.top, 4)
        }
        .padding(.top, 30)
        .padding(.horizontal, 24)
    }

    private func emailInputView(
        _ type: SignUpInputType,
        _ password: Binding<String>
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
                TextField(type.subtitle, text: password)
                    .focused($focusField, equals: type)
                if focusField == type {
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
                .foregroundStyle(focusField == type ?
                                 Color(uiColor: .primaryColor) : Color(uiColor: .gray95))
                .padding(.top, 4)
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

    var nextButton: some View {
        Button {
            signUpState = .email
            Task {
            }
        } label: {
            RoundedRectangle(cornerRadius: 15.0)
                .frame(height: 50)
                .overlay {
                    Text("다음")
                        .font(.h5)
                        .foregroundStyle(Color(uiColor: .white))
                }
        }
        //        .disabled(!viewModel.isButtonEnabled)
        .padding(.horizontal, 24)
        .padding(.bottom, 24)
    }

    var emailAndBackButton: some View {
        HStack {
            Button {
                signUpState = .idAndPassword
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
                print(focusField)
            } label: {
                RoundedRectangle(cornerRadius: 15.0)
                    .frame(height: 50)
                    .overlay {
                        Text("인증메일 전송")
                            .font(.h5)
                            .foregroundStyle(Color(uiColor: .white))
                    }
            }
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 24)
    }

}

enum SignUpInputType: CaseIterable {
    case id
    case password
    case checkPassword
    case email

    var title: String {
        switch self {
        case .id:
            "아이디"
        case .password:
            "비밀번호"
        case .checkPassword:
            "비밀번호 확인"
        case .email:
            "이메일"
        }
    }

    var subtitle: String {
        switch self {
        case .id:
            "6~20자의 영문, 숫자 조합"
        case .password:
            "8~20자의 영문, 숫자, 특수문자 조합"
        case .checkPassword:
            "비밀번호 재입력"
        case .email:
            "@suwon.ac.kr"
        }
    }
}

enum SignUpState {
    case idAndPassword
    case email

    var title: String {
        switch self {
        case .idAndPassword:
            "회원가입"
        case .email:
            "학교 이메일을 입력하세요."
        }
    }
}

#Preview {
    SignUpView()
}
