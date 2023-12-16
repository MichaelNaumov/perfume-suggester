//
//  PerfumeSuggesterApp.swift
//  PerfumeSuggester
//
//  Created by Mykhailo Naumov on 10.12.2023.
//

import SwiftUI
import SwiftData

extension Color {
    static let papaya = Color(red: 0xE5 / 255, green: 0x67 / 255, blue: 0x17 / 255)
}

@main
struct PerfumeApp: App {
    @StateObject private var viewModel = PerfumeViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel).accentColor(.papaya)
        }
    }
}
