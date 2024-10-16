//
//  UserInfoView.swift
//  SUWIKI
//
//  Created by 한지석 on 4/3/24.
//

import SwiftUI

import Domain

import ComposableArchitecture

struct UserInfoView: View {

  @EnvironmentObject var appState: AppState
  @State var path = NavigationPath()
  @StateObject var viewModel = UserInfoViewModel()

  @Bindable var store: StoreOf<UserInfoFeature>

  init(store: StoreOf<UserInfoFeature>) {
    self.store = store
  }

  var body: some View {
    WithPerceptionTracking {
      NavigationStackStore(store.scope(state: \.path, action: \.path)) {
        ZStack {
          Color(uiColor: .systemGray6)
            .ignoresSafeArea()
          VStack {
            if store.requestState == .success {
              if store.isLoggedIn {
                loginStateButton
                  .padding(.top, 20)
                  .padding(.bottom, 12)
              } else {
                logoutStateButton
                  .padding(.top, 20)
                  .padding(.bottom, 12)
              }
              HStack {
                navigationLinkButtons(type: .announcement)
                linkButton(type: .inquire)
                navigationLinkButtons(type: .manageAccount)
              }
              .padding(.bottom, 12)
              if store.isLoggedIn {
                loginServices
              }
              services
              Spacer()
            } else {
              ProgressView()
            }
          }
        }
        .onAppear {
          store.send(.internalAction(.initialize))
        }
      }
      destination: { state in
        switch state {
        case .manageAccount:
          CaseLet(/UserInfoFeature.Path.State.manageAccount, action: UserInfoFeature.Path.Action.manageAccount) { store in
            ManageAccountView(store: store)
          }
        }
      }
      .sheet(
        item: $store.scope(
          state: \.destination?.login,
          action: \.destination.login
        )
      ) { store in
        LoginView(store: store)
      }
    }
  }

  //      .navigationdestination
  //      .sheet(isPresented: $viewModel.isLoginViewPresented, onDismiss: {
  //        if appState.isLoggedIn {
  //          Task {
  //            try await viewModel.getUserInfo()
  //          }
  //        }
  //      }) {
  //        LoginView()
  //      }

  var loginStateButton: some View {
    Button {
      print("UserPostView")
    } label: {
      RoundedRectangle(cornerRadius: 10)
        .foregroundStyle(Color(uiColor: .white))
        .overlay(alignment: .leading) {
          HStack {
            VStack(alignment: .leading,
                   spacing: 4) {
              if let userInfo = store.userInfo {
                Text(userInfo.id)
                  .font(.h3)
                  .tint(Color(uiColor: .black))
                HStack {
                  Image(systemName: "p.circle.fill")
                    .resizable()
                    .foregroundStyle(Color(uiColor: .systemYellow))
                    .frame(width: 16, height: 16)
                  Text("\(userInfo.point)")
                    .font(.b5)
                    .tint(Color(uiColor: .basicBlack))
                }
              }
            }
            Spacer()
            Text("내 글 관리")
              .font(.b5)
              .tint(.black)
            Image(systemName: "chevron.right")
              .foregroundStyle(Color(uiColor: .grayDA))
          }
          .padding(.horizontal, 16)
        }
    }
    .frame(height: 86)
    .padding(.horizontal, 24)
  }

  var logoutStateButton: some View {
    Button {
      store.send(.viewAction(.loginButtonTapped))
    } label: {
      RoundedRectangle(cornerRadius: 10)
        .foregroundStyle(Color(uiColor: .white))
        .overlay(alignment: .leading) {
          VStack(alignment: .leading,
                 spacing: 4) {
            HStack {
              Text("로그인하세요")
                .font(.h3)
                .tint(Color(uiColor: .black))
              Image(systemName: "chevron.right")
                .foregroundStyle(Color(uiColor: .grayDA))
            }
            Text("내 글과 포인트, 구매 내역을 확인해보세요.")
              .font(.b5)
              .tint(Color(uiColor: .gray95))
          }
                 .padding(.leading, 16)
        }
    }
    .frame(height: 86)
    .padding(.horizontal, 24)
  }

  func linkButton(type: ManageButtonType) -> some View {
    HStack {
      Link(destination: URL(string: "https://alike-pump-ae3.notion.site/SUWIKI-2cd58468e90b404fbd3e30b8b2c0b699")!) {
        VStack {
          type.image
            .resizable()
            .frame(width: 18, height: 18)
            .padding(.bottom, 4)
          Text(type.title)
            .font(.c2)
            .tint(.black)
        }
      }
      .frame(width: 60, height: 60)
      .padding(.horizontal, 24)
      Rectangle()
        .frame(width: 1, height: 49)
        .foregroundStyle(Color(uiColor: .grayCB))
    }
  }

  func navigationLinkButtons(type: ManageButtonType) -> some View {
    HStack {
      Button {
        if type == .announcement {
          print("announcement")
        } else {
          if store.userInfo != nil {
            store.send(.viewAction(.manageButtonTapped))
          }
          else {
            print("Login")
          }
        }
      } label: {
        VStack {
          type.image
            .resizable()
            .frame(width: 18, height: 18)
            .padding(.bottom, 4)
          Text(type.title)
            .font(.c2)
            .tint(.black)
        }
      }
      .frame(width: 60, height: 60)
      .padding(.horizontal, 24)
      if type == .announcement {
        Rectangle()
          .frame(width: 1, height: 49)
          .foregroundStyle(Color(uiColor: .grayCB))
      }
    }
  }

  var logoutServices: some View {
    Text("Logout")
  }

  var services: some View {
    Section {
      ForEach(ServiceType.allCases, id: \.self) { type in
        Link(destination: type.url) {
          HStack {
            Text(type.title)
              .font(.b2)
              .foregroundStyle(Color.black)
            Spacer()
          }
          .frame(height: 50)
          .padding(.leading, 16)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal, 24)
      }
    } header: {
      HStack {
        Text("서비스")
          .font(.b5)
          .foregroundStyle(Color(uiColor: .gray95))
        Spacer()
      }
      .padding(.horizontal, 28)
      .padding(.top, 12)
    }
  }

  var loginServices: some View {
    Section {
      Button {
//        if let userInfo = viewModel.userInfo {
//          UserPointView(userInfo: userInfo)
//        } else {
//          Text("다시 로그인하세요")
//        }
        print("Hi")
      } label: {
        HStack {
          Text("내 포인트")
            .font(.b2)
            .foregroundStyle(Color.black)
          Spacer()
        }
        .frame(height: 50)
        .padding(.leading, 16)
      }
      .background(Color.white)
      .clipShape(RoundedRectangle(cornerRadius: 10))
      .padding(.horizontal, 24)
    } header: {
      HStack {
        Text("MY")
          .font(.b5)
          .foregroundStyle(Color(uiColor: .gray95))
        Spacer()
      }
      .padding(.horizontal, 28)
    }
  }
}
