//
//  LectureEvaluationDetailFeature.swift
//  Presentation
//
//  Created by 한지석 on 10/11/24.
//

import Foundation

import ComposableArchitecture

@Reducer
struct LectureEvaluationDetailFeature {

  @ObservableState
  struct State: Equatable {
    
  }

  enum Action {
    case onAppear
  }

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        return .none
      }
    }
  }
}
