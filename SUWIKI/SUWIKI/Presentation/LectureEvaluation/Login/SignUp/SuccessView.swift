//
//  SuccessView.swift
//  SUWIKI
//
//  Created by 한지석 on 4/10/24.
//

import SwiftUI

/// Success
extension SignUpView {
    var successView: some View {
        VStack {
            Image("success")
                .padding(.top, 50)
                .padding(.bottom, 22)
            Text("가입 완료를 위해 이메일을 확인하세요.")
                .font(.h2)
                .padding(.bottom, 8)
            Text("인증 링크를 확인하지 않으면\n서비스 이용에 제한이 생겨요!")
                .font(.h7)
                .foregroundStyle(Color(uiColor: .gray6A))
        }
    }

    var successButtons: some View {
        VStack {
            Link(destination: URL(string: "https://portal.suwon.ac.kr/enview/index.html")!) {
                RoundedRectangle(cornerRadius: 15.0)
                    .frame(height: 50)
                    .overlay {
                        Text("이메일 확인하기")
                            .font(.h5)
                            .foregroundStyle(Color(uiColor: .white))
                    }
            }
            .padding(.bottom, 6)

            Button {
                dismiss()
            } label: {
                RoundedRectangle(cornerRadius: 15.0)
                    .foregroundStyle(Color.white)
                    .frame(height: 50)
                    .overlay {
                        Text("로그인")
                            .font(.h5)
                            .foregroundStyle(Color(uiColor: .primaryColor))
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color(uiColor: .primaryColor),
                                    lineWidth: 1)
                    }
            }
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 24)
    }
}
