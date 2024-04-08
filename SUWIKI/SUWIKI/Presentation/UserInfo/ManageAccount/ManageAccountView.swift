//
//  ManageAccountView.swift
//  SUWIKI
//
//  Created by 한지석 on 4/5/24.
//

import SwiftUI

struct ManageAccountView: View {
    
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
                Text("iostest")
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
                Text("sozohoy@suwon.ac.kr")
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

#Preview {
    ManageAccountView()
}
