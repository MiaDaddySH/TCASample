//
//  CounterFeature.swift .swift
//  TCASample
//
//  Created by Yuangang Sheng on 03.11.23.
//

import ComposableArchitecture

struct CounterFeature: Reducer {
  struct State: Equatable {
    var count = 0
  }
  
  enum Action {
    case decrementButtonTapped
    case incrementButtonTapped
  }
  
  func reduce(into state: inout State, action: Action) -> ComposableArchitecture.Effect<Action> {
    switch action {
    case .decrementButtonTapped:
      state.count -= 1
      return .none
    case .incrementButtonTapped:
      state.count += 1
      return .none
    }
  }
}
