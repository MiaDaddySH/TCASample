//
//  TCASampleApp.swift
//  TCASample
//
//  Created by Yuangang Sheng on 03.11.23.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCASampleApp: App {
  static let store = Store(initialState: CounterFeature.State()) {
      CounterFeature()
      ._printChanges()
    }

  var body: some Scene {
    WindowGroup {
      CounterView(store: TCASampleApp.store)
    }
  }
}
