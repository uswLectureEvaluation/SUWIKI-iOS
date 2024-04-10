//
//  FindIDView.swift
//  SUWIKI
//
//  Created by 한지석 on 4/9/24.
//

import SwiftUI

struct FindIDView: View {
    
    @FocusState private var focusField: FindIDInputType?
    @State var id: String = ""
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .ignoresSafeArea()
            VStack {
                emailInputView
                Spacer()
                findIDButton
            }
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
                    .foregroundStyle(focusField == .email ? Color(uiColor: .primaryColor) : Color(uiColor: .gray95))
                Spacer()
            }
            HStack {
                TextField("@suwon.ac.kr", text: $id)
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
                .foregroundStyle(focusField == .email ? Color(uiColor: .primaryColor) : Color(uiColor: .gray95))
                .padding(.top, 4)
            if focusField == .email {
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

    private var findIDButton: some View {
        Button {
//            viewModel.signUpStateChange()
        } label: {
            RoundedRectangle(cornerRadius: 15.0)
                .frame(height: 50)
                .overlay {
                    Text("아이디 찾기")
                        .font(.h5)
                        .foregroundStyle(Color(uiColor: .white))
                }
        }
//        .disabled(!viewModel.isNextButtonEnabled)
        .padding(.horizontal, 24)
        .padding(.bottom, 24)
    }
}

enum FindIDInputType {
    case email
}

#Preview {
    FindIDView()
}
