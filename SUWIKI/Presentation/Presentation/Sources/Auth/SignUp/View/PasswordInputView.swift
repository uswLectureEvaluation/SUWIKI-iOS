//
//  PasswordInputView.swift
//  SUWIKI
//
//  Created by 한지석 on 4/10/24.
//

import SwiftUI

extension SignUpView {
  func passwordInputViews(
    _ type: SignUpInputType,
    _ text: Binding<String>,
    _ isVaild: Binding<Bool>,
    _ visible: Binding<Bool>
  ) -> some View {
    VStack {
      HStack {
        Text(type.title)
          .font(.c2)
          .foregroundStyle(focusField == type ?
                           (isVaild.wrappedValue ?
                            Color(uiColor: .primaryColor) : Color(uiColor: .red))
                           : Color(uiColor: .gray95))
        Spacer()
      }
      HStack {
        if visible.wrappedValue {
          TextField(type.subtitle, text: text)
            .focused($focusField, equals: type)
        } else {
          SecureField(type.subtitle, text: text)
            .focused($focusField, equals: type)
        }
        
        if focusField == type {
          Button {
            visible.wrappedValue.toggle()
          } label: {
            Image(systemName: visible.wrappedValue ? "lock" : "lock.slash")
              .foregroundStyle(Color(uiColor: .gray95))
              .frame(width: 18, height: 18)
          }
        }
        if focusField == type {
          Button {
            text.wrappedValue = ""
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
        .foregroundStyle(focusField == type ?
                         (isVaild.wrappedValue ?
                          Color(uiColor: .primaryColor) : Color(uiColor: .red))
                         : Color(uiColor: .gray95))
        .padding(.top, 4)
      HStack {
        Text(focusField == type && !isVaild.wrappedValue ? type.warning : "")
          .font(.c4)
          .foregroundStyle(Color.red)
          .frame(height: 18)
        Spacer()
      }
    }
    .padding(.top, 4)
    .padding(.horizontal, 24)
  }
}
