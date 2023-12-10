// ContentView.swift
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: PerfumeViewModel

    // Filter
    @State private var filteredPerfumes: [Perfume] = []

    // New Perfume
    @State private var perfumeName = ""
    @State private var selectedSeasons = ["Spring"]
    @State private var selectedDayTimes = ["Day"]

    var body: some View {
        TabView {
            // First Tab: Filter Perfumes
            FilterPerfumeTab(viewModel: viewModel)

            // Second Tab: Add New Perfume
            AddPerfumeTab(viewModel: viewModel,
                          perfumeName: $perfumeName,
                          selectedSeasons: $selectedSeasons,
                          selectedDayTimes: $selectedDayTimes)
        }
    }
}
