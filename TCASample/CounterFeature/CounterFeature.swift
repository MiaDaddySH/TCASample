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
    var isTimerRunning = false
  }
  
  enum Action: Equatable {
    case decrementButtonTapped
    case factButtonTapped
    case factResponse(String)
    case incrementButtonTapped
    case timerTick
    case toggleTimerButtonTapped
  }
  
  enum CancelID { case timer }
  
  // 2. Testing Features
//  @Dependency(\.continuousClock) var clock
  
  // 3. Testing Network Request
//  @Dependency(\.numberFact) var numberFact
  
  func reduce(into state: inout State, action: Action) -> ComposableArchitecture.Effect<Action> {
    switch action {
    case .incrementButtonTapped:
      state.count += 1
      state.fact = nil
      return .none
      
    case .decrementButtonTapped:
      state.count -= 1
      state.fact = nil
      return .none
      
    case .toggleTimerButtonTapped:
      state.isTimerRunning.toggle()
      if state.isTimerRunning {
        // 2. Testing Features: Before
        return .run { send in
          while true {
            try await Task.sleep(for: .seconds(1))
            await send(.timerTick)
          }
        }
        .cancellable(id: CancelID.timer)
        // 2. Testing Features: After
//        return .run { send in
//          for await _ in self.clock.timer(interval: .seconds(1)) {
//            await send(.timerTick)
//          }
//        }
//       .cancellable(id: CancelID.timer)
      } else {
        return .cancel(id: CancelID.timer)
      }
      
    case .timerTick:
      state.count += 1
      state.fact = nil
      return .none
      
    case .factButtonTapped:
      state.fact = nil
      state.isLoading = true
      
      return .run { [count = state.count] send in
        // 3. Testing Nerwork Request: Before
        let (data, _) = try await URLSession.shared
          .data(from: URL(string: "http://numbersapi.com/\(count)")!)
        let fact = String(decoding: data, as: UTF8.self)
        await send(.factResponse(fact))
        
        // 3. Testing Nerwork Request: After
//        try await send(.factResponse(self.numberFact.fetch(count)))
      }
      
    case let .factResponse(fact):
      state.fact = fact
      state.isLoading = false
      return .none
    }
  }
}
