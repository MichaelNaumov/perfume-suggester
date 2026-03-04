// ContentView.swift
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: PerfumeViewModel

    var body: some View {
        TabView {
            FilterPerfumeTab(viewModel: viewModel)
            AddPerfumeTab(viewModel: viewModel)
            AllPerfumesTab(viewModel: viewModel)
        }
    }
}
