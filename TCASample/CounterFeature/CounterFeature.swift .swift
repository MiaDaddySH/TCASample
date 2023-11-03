//
//  CounterFeature.swift .swift
//  TCASample
//
//  Created by Yuangang Sheng on 03.11.23.
//

import ComposableArchitecture
import Foundation

struct CounterFeature: Reducer {
  struct State: Equatable {
    var count = 0
    var fact: String?
    var isLoading = false
  }
  
  enum Action {
    case decrementButtonTapped
    case factButtonTapped
    case factResponse(String)
    case incrementButtonTapped
  }
  
  func reduce(into state: inout State, action: Action) -> ComposableArchitecture.Effect<Action> {
    switch action {
    case .decrementButtonTapped:
      state.count -= 1
      state.fact = nil
      return .none
    case .factButtonTapped:
      state.fact = nil
      state.isLoading = true
      
      return .run { [count = state.count] send in
        let (data, _) = try await URLSession.shared
          .data(from: URL(string: "http://numbersapi.com/\(count)")!)
        let fact = String(decoding: data, as: UTF8.self)
        await send(.factResponse(fact))
      }
      
    case let .factResponse(fact):
      state.fact = fact
      state.isLoading = false
      return .none
        
    case .incrementButtonTapped:
      state.count += 1
      state.fact = nil
      return .none
    }
  }
}
