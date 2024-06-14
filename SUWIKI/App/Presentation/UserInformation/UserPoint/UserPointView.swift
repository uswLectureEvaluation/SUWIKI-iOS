//
//  UserPointView.swift
//  SUWIKI
//
//  Created by 한지석 on 4/8/24.
//

import SwiftUI

import Domain

struct UserPointView: View {
  
  var descriptions: [String] = [
    "· 포인트는 강의평가 서비스 내에서만 이용 가능합니다.",
    "· 다른 계정으로 학교 인증 시 해당 계정으로 포인트가 합산 되며, 기존 포인트는 초기화 됩니다.",
    "· 포인트 획득을 위해 허위/중복/성의없는 정보를 작성 할 경우 서비스 이용이 제한 될 수 있습니다.",
    "· 허위 신고를 남용하는 이용자 또한 서비스 이용에 대한 제재가 가해질 수 있습니다.",
  ]
  
  var pointPolicies: [String] = [
    "· 강의평 작성 : 10p 적립",
    "· 시험정보 작성 : 20p 적립",
    "· 신고 보상 : 1p 적립",
    "· 시험정보 조회 : -20p",
    "· 강의평가/시험정보 삭제 : -30p"
  ]
  
  @StateObject var viewModel: UserPointViewModel
  
  init(userInfo: UserInfo) {
    self._viewModel = StateObject(
      wrappedValue:
        UserPointViewModel(point: userInfo.point,
                           writtenEvaluationPosts: userInfo.writtenEvaluationPosts,
                           writtenExamPosts: userInfo.writtenExamPosts,
                           purchasedExamPosts: userInfo.purchasedExamPosts)
    )
  }
  
  var body: some View {
    ZStack {
      Color(uiColor: .systemGray6)
        .ignoresSafeArea()
      ScrollView {
        title
          .padding(.bottom, 8)
        pointView("현재 포인트", "\(viewModel.point)p")
        pointView("작성한 강의평가(\(viewModel.writtenEvaluationPosts))",
                  "+\(viewModel.writtenEvaluationPosts * 10)p")
        pointView("작성한 시험정보(\(viewModel.writtenExamPosts))",
                  "+\(viewModel.writtenEvaluationPosts * 20)p")
        pointView("시험정보 열람(\(viewModel.purchasedExamPosts))",
                  "-\(viewModel.purchasedExamPosts * 20)p")
        descriptionView
          .padding(.top, 16)
          .padding(.bottom, 16)
        pointPoliciesView
          .padding(.bottom, 24)
        subtitle
          .padding(.bottom, 12)
        purchasedList
      }
    }
  }
  
  private var title: some View {
    HStack {
      Text("포인트 현황")
        .font(.b2)
        .foregroundStyle(.black)
      Spacer()
    }
    .padding(.horizontal, 24)
  }
  
  private func pointView(
    _ title: String,
    _ point: String
  ) -> some View {
    VStack {
      HStack {
        Text(title)
          .font(.c1)
          .foregroundStyle(Color(uiColor: .gray95))
        Spacer()
        Text(point)
          .font(.b5)
      }
      .padding(.horizontal, 24)
      .padding(.bottom, 6)
      Divider()
    }
    .padding(.top, 6)
  }
  
  private var descriptionView: some View {
    VStack {
      ForEach(descriptions.indices, id: \.self) { index in
        HStack {
          Text(descriptions[index])
            .font(.c4)
          Spacer()
        }
        .padding(.bottom, 1)
      }
    }
    .padding(.horizontal, 24)
  }
  
  private var pointPoliciesView: some View {
    VStack {
      ForEach(pointPolicies.indices, id: \.self) { index in
        HStack {
          Text(pointPolicies[index])
            .font(.c4)
          Spacer()
        }
        .padding(.bottom, 1)
      }
    }
    .padding(.horizontal, 24)
  }
  
  private var subtitle: some View {
    HStack {
      Text("포인트 사용 내역")
        .font(.b2)
        .foregroundStyle(.black)
      Spacer()
    }
    .padding(.horizontal, 24)
  }
  
  private var purchasedList: some View {
    VStack {
      ForEach(viewModel.purchasedPosts, id: \.self) { post in
        HStack {
          Text(post.date)
            .font(.c1)
            .foregroundStyle(Color(uiColor: .gray95))
          Spacer()
          Text(post.name)
            .font(.b5)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 6)
        Divider()
      }
      .padding(.top, 6)
    }
  }
}
