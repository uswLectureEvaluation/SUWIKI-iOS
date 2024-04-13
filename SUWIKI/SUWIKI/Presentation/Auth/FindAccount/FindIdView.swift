//
//  FindIDView.swift
//  SUWIKI
//
//  Created by 한지석 on 4/9/24.
//

import SwiftUI

struct FindIdView: View {

    @FocusState private var focusField: FindIdInputType?
    @StateObject var viewModel = FindIdViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .ignoresSafeArea()
            VStack {
                emailInputView
                Spacer()
                findIdButton
            }
        }
        .alert("계정을 확인해주세요!", isPresented: $viewModel.isFindIdFailure) {
            Button("확인") { }
        } message: {
            Text("해당 계정을 찾을 수 없습니다.")
        }
        .alert("이메일이 발송되었습니다.", isPresented: $viewModel.isFindIdSuccess) {
            Button("확인") { dismiss() }
        } message: {
            Text("이메일 수신함을 확인해주세요.")
        }
        .navigationTitle("아이디 찾기")
        .navigationBarTitleDisplayMode(.large)
    }
    
    @ViewBuilder
    private var emailInputView: some View {
        VStack {
            HStack {
                Text("학교 이메일")
                    .font(.c2)
                    .foregroundStyle(focusField == .email ? 
                                     (viewModel.isEmailVaild ? Color(uiColor: .primaryColor) : Color(uiColor: .red))
                                     : Color(uiColor: .gray95))
                Spacer()
            }
            HStack {
                TextField("@suwon.ac.kr", text: $viewModel.email)
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
                                 (viewModel.isEmailVaild ? Color(uiColor: .primaryColor) : Color(uiColor: .red))
                                 : Color(uiColor: .gray95))
                .padding(.top, 4)
            if focusField == .email && !viewModel.isEmailVaild {
                HStack {
                    Text("올바른 형식의 수원대학교 이메일을 입력해주세요.")
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

    private var findIdButton: some View {
        Button {
            Task {
                try await viewModel.findId()
            }
        } label: {
            RoundedRectangle(cornerRadius: 15.0)
                .frame(height: 50)
                .overlay {
                    Text("아이디 찾기")
                        .font(.h5)
                        .foregroundStyle(Color(uiColor: .white))
                }
        }
        .disabled(!viewModel.isEmailVaild)
        .padding(.horizontal, 24)
        .padding(.bottom, 24)
    }
}

enum FindIdInputType {
    case email
}
