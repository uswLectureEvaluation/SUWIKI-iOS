//
//  UserInfoView.swift
//  SUWIKI
//
//  Created by 한지석 on 4/3/24.
//

import SwiftUI

struct UserInfoView: View {

    @EnvironmentObject var appState: AppState
    @State var path = NavigationPath()
    @StateObject var viewModel = UserInfoViewModel()

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color(uiColor: .systemGray6)
                    .ignoresSafeArea()
                VStack {
                    if viewModel.requestState == .success {
                        if appState.isLoggedIn {
                            loginStateButton
                                .padding(.top, 20)
                                .padding(.bottom, 12)
                        } else {
                            logoutStateButton
                                .padding(.top, 20)
                                .padding(.bottom, 12)
                        }
                        manageButtons
                            .padding(.bottom, 12)
                        if appState.isLoggedIn {
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
                Task {
                    try await viewModel.getUserInfo()
                }
            }
        }


    }

    var loginStateButton: some View {
        NavigationLink {
            UserPostView()
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color(uiColor: .white))
                .overlay(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading,
                               spacing: 4) {
                            if let userInfo = viewModel.userInfo {
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

    var manageButtons: some View {
        HStack {
            ForEach(ManageButtonType.allCases, id: \.self) { type in
                NavigationLink {
                    switch type {
                    case .announcement:
                        AnnouncementView()
                    case .manageAccount:
                        if let userInfo = viewModel.userInfo {
                            ManageAccountView(userInfo: userInfo)
                        } else {
                            LoginView()
                        }
                    default:
                        Text("hi")
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
                if type != .manageAccount {
                    Rectangle()
                        .frame(width: 1, height: 49)
                        .foregroundStyle(Color(uiColor: .grayCB))
                }
            }
        }
    }

    var logoutServices: some View {
        Text("Logout")
    }

    var services: some View {
        Section {
            ForEach(ServiceType.allCases, id: \.self) { type in

                Button {

                } label: {
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
            NavigationLink {
                if let userInfo = viewModel.userInfo {
                    UserPointView(userInfo: userInfo)
                } else {
                    Text("다시 로그인하세요")
                }
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
    #Preview {
        UserInfoView()
    }
