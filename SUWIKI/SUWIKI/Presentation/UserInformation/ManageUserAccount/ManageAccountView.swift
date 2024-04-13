//
//  ManageAccountView.swift
//  SUWIKI
//
//  Created by 한지석 on 4/5/24.
//

import SwiftUI

struct ManageAccountView: View {

    @StateObject var viewModel: ManageAccountViewModel
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState

    init(userInfo: UserInfo) {
        self._viewModel = StateObject(wrappedValue: ManageAccountViewModel(userInfo: userInfo))
    }

    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .ignoresSafeArea()
            VStack {
                loginIdView
                    .padding(.top, 20)
                emailView
                changePasswordButton
                    .padding(.top, 8)
                logoutButton
                withdrawAccountButton
                Spacer()
            }
            .navigationTitle("내 계정")
            .alert("로그아웃 하시겠어요?", isPresented: $viewModel.isLogoutButtonTapped) {
                Button("확인") { 
                    viewModel.logout()
                    appState.isLoggedIn = false
                    dismiss()
                }
                Button(role: .cancel) {
                } label: {
                    Text("취소")
                }
            }
        }
    }

    var title: some View {
        Text("내 계정")
            .font(.b2)
    }

    var loginIdView: some View {
        VStack {
            HStack {
                Text("로그인 아이디")
                    .font(.c1)
                    .foregroundStyle(Color(uiColor: .gray95))
                Spacer()
                Text(viewModel.userInfo.id)
                    .font(.b5)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 6)
            Divider()
        }
        .padding(.top, 6)
    }

    var emailView: some View {
        VStack {
            HStack {
                Text("학교 인증 메일")
                    .font(.c1)
                    .foregroundStyle(Color(uiColor: .gray95))
                Spacer()
                Text(viewModel.userInfo.email)
                    .font(.b5)
                    .tint(.black)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 6)
            Divider()
        }
        .padding(.top, 6)
    }

    var changePasswordButton: some View {
        NavigationLink {
            ChangePasswordView()
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
                .frame(height: 50)
                .overlay {
                    HStack {
                        Text("비밀번호 변경")
                            .font(.b2)
                            .foregroundStyle(.black)
                        Spacer()
                    }
                    .padding(.leading, 16)
                }
        }
        .padding(.horizontal, 24)

    }

    var logoutButton: some View {
        Button {
            viewModel.isLogoutButtonTapped.toggle()
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
                .frame(height: 50)
                .overlay {
                    HStack {
                        Text("로그아웃")
                            .font(.b2)
                            .foregroundStyle(.black)
                        Spacer()
                    }
                    .padding(.leading, 16)
                }
        }
        .padding(.horizontal, 24)
    }

    var withdrawAccountButton: some View {
        NavigationLink {
            WithDrawAccountView()
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
                .frame(height: 50)
                .overlay {
                    HStack {
                        Text("회원탈퇴")
                            .font(.b2)
                            .foregroundStyle(.black)
                        Spacer()
                    }
                    .padding(.leading, 16)
                }
        }
        .padding(.horizontal, 24)
    }
}
