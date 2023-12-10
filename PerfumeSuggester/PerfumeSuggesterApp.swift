//
//  PerfumeSuggesterApp.swift
//  PerfumeSuggester
//
//  Created by Mykhailo Naumov on 10.12.2023.
//

import SwiftUI
import SwiftData

@main
struct PerfumeApp: App {
    @StateObject private var viewModel = PerfumeViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
