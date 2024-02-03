//
//  LoginView.swift
//  SUWIKI
//
//  Created by 한지석 on 2/3/24.
//

import SwiftUI

enum LoginViewInputType: CaseIterable {
    case id
    case password
}

enum LoginViewButtonType: CaseIterable {
    case findId
    case findPassword
    case signIn
}

struct LoginView: View {

    @State var id: String = ""
    @State var password: String = ""

    var body: some View {
        VStack {
            title
            ForEach(LoginViewInputType.allCases, id: \.self) { input in
                inputView(input)
            }
            Spacer()
            eventBox
        }
    }

    var title: some View {
        Text("로그인")
            .font(.h1)
            .padding(.top, 60)
    }

    func inputView(
        _ type: LoginViewInputType
    ) -> some View {
        VStack {
            HStack {
                Text(type == .id ? "아이디" : "비밀번호")
                    .font(.c2)
                    .foregroundStyle(Color(uiColor: .gray95))
                Spacer()
            }
            TextField(type == .id ?
                      "아이디를 입력하세요." : "비밀번호를 입력하세요.",
                      text: $id)
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color(uiColor: .gray95))
        }
        .padding(.top, type == .id ? 26 : 20)
        .padding(.horizontal, 24)
    }

    var eventBox: some View {
        HStack {
            Text("아이디 찾기")
                .font(.b5)
                .foregroundStyle(Color(uiColor: .gray6A))
            Rectangle()
                .frame(width: 1, height: 12)
                .foregroundStyle(Color(uiColor: .grayF6))
            Text("비밀번호 찾기")
                .font(.b5)
                .foregroundStyle(Color(uiColor: .gray6A))
            Rectangle()
                .frame(width: 1, height: 12)
                .foregroundStyle(Color(uiColor: .grayF6))
            Text("회원가입")
                .font(.b5)
                .foregroundStyle(Color(uiColor: .primaryColor))
        }
    }

    func buttons(
        _ type: LoginViewButtonType
    ) -> some View {
        Button {
            
        } label: {

        }
    }

}

#Preview {
    LoginView()
}
