//
//  WithDrawAccountView.swift
//  SUWIKI
//
//  Created by 한지석 on 4/11/24.
//

import SwiftUI

import Domain

struct WithDrawAccountView: View {
  
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var appState: AppState
  @StateObject var viewModel = WithDrawAccountViewModel()
  @FocusState var focusField: LoginViewInputType?
  
  var body: some View {
    ZStack {
      Color(uiColor: .systemGray6)
        .ignoresSafeArea()
      VStack {
        inputViews(.id)
        inputViews(.password)
        Spacer()
        withDrawButton
      }
    }
    .navigationTitle("회원 탈퇴")
    .navigationBarTitleDisplayMode(.large)
    .alert("회원탈퇴 하시겠어요?", isPresented: $viewModel.isAlertPresented) {
      Button("확인") {
        Task {
          try await viewModel.withDraw()
        }
      }
      Button(role: .cancel) {
      } label: {
        Text("취소")
      }
    }
    .alert("계정 정보가 일치하지 않습니다.", isPresented: $viewModel.isWithDrawFailure) {
      Button("확인") { }
    } message: {
      Text("입력 정보를 확인해주세요.")
    }
    .alert("회원탈퇴 되었습니다.", isPresented: $viewModel.isWithDrawSuccess) {
      Button("확인") { 
        viewModel.deleteTokens()
        appState.isLoggedIn = false
        dismiss()
      }
    } message: {
      Text("수위키를 이용해주셔서 감사합니다.")
    }
  }
  
  private func inputViews(
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
          TextField("아이디를 입력하세요.", text: $viewModel.id)
            .focused($focusField, equals: .id)
          if focusField == type {
            Button {
              viewModel.id = ""
            } label: {
              Image(systemName: "x.circle.fill")
                .foregroundStyle(Color(uiColor: .gray95))
                .frame(width: 18, height: 18)
            }
          }
        }
      } else {
        HStack {
          if viewModel.isPasswordVisible {
            TextField("비밀번호를 입력하세요.", text: $viewModel.password)
              .focused($focusField, equals: .password)
          } else {
            SecureField("비밀번호를 입력하세요",text: $viewModel.password)
              .focused($focusField, equals: .password)
          }
          if focusField == type {
            Button {
              viewModel.isPasswordVisible.toggle()
            } label: {
              Image(systemName: viewModel.isPasswordVisible ? "lock" : "lock.slash")
                .foregroundStyle(Color(uiColor: .gray95))
                .frame(width: 18, height: 18)
            }
          }
          if focusField == type {
            Button {
              viewModel.password = ""
            } label: {
              Image(systemName: "x.circle.fill")
                .foregroundStyle(Color(uiColor: .gray95))
                .frame(width: 18, height: 18)
            }
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
  
  private var withDrawButton: some View {
    Button {
      viewModel.isAlertPresented.toggle()
    } label: {
      RoundedRectangle(cornerRadius: 15.0)
        .frame(height: 50)
        .overlay {
          Text("회원탈퇴")
            .font(.h5)
            .foregroundStyle(Color(uiColor: .white))
        }
    }
    .disabled(!viewModel.isButtonEnabled)
    .padding(.horizontal, 24)
    .padding(.bottom, 24)
  }
}
