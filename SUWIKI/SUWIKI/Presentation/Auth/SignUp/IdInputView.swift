//
//  IDInputView.swift
//  SUWIKI
//
//  Created by 한지석 on 4/10/24.
//

import SwiftUI

/// ID
extension SignUpView {
    @ViewBuilder
    var idInputView: some View {
        VStack {
            HStack {
                Text(SignUpInputType.id.title)
                    .font(.c2)
                    .foregroundStyle(focusField == .id ?
                                     (viewModel.isIdVaild && viewModel.isIdAvailabled ?
                                      Color(uiColor: .primaryColor) : Color(uiColor: .red))
                                     : Color(uiColor: .gray95))
                Spacer()
            }
            HStack {
                TextField(SignUpInputType.id.subtitle, text: $viewModel.id)
                    .focused($focusField, equals: .id)

                if focusField == .id {
                    Button {
                        viewModel.id = ""
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
                .foregroundStyle(focusField == .id ?
                                 (viewModel.isIdVaild && viewModel.isIdAvailabled ?
                                  Color(uiColor: .primaryColor) : Color(uiColor: .red))
                                 : Color(uiColor: .gray95))
                .padding(.top, 4)
            HStack {
                if focusField == .id {
                    Text(viewModel.isIdVaild ?
                         (viewModel.isIdAvailabled ? "" : "중복된 아이디입니다.")
                         : SignUpInputType.id.warning)
                    .font(.c4)
                    .foregroundStyle(Color.red)
                    .frame(height: 18)
                }
                Spacer()
            }
            .frame(height: 18)
        }
        .padding(.top, 16)
        .padding(.horizontal, 24)
    }

    var nextButton: some View {
        Button {
            viewModel.signUpStateChange()
        } label: {
            RoundedRectangle(cornerRadius: 15.0)
                .frame(height: 50)
                .overlay {
                    Text("다음")
                        .font(.h5)
                        .foregroundStyle(Color(uiColor: .white))
                }
        }
        .disabled(!viewModel.isNextButtonEnabled)
        .padding(.horizontal, 24)
        .padding(.bottom, 24)
    }
}
