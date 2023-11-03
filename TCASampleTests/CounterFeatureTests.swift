//
//  CounterFeatureTests.swift
//  TCASampleTests
//
//  Created by Yuangang Sheng on 03.11.23.
//

import ComposableArchitecture
import XCTest
@testable import TCASample

@MainActor
final class CounterFeatureTests: XCTestCase {
  func testCounter() async {
    let store = TestStore(initialState: CounterFeature.State()) {
      CounterFeature()
    }
    
    await store.send(.incrementButtonTapped) {
      $0.count = 1
    }
    await store.send(.decrementButtonTapped) {
      $0.count = 0
    }
  }
}
