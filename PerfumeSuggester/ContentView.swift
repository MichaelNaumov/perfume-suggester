// ContentView.swift
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: PerfumeViewModel

    // Filter
    @State private var filteredPerfumes: [Perfume] = []

    // New Perfume
    @State private var perfumeName = ""
    @State private var perfumeBrand = ""
    @State private var selectedSeasons: [String] = []
    @State private var selectedDayTimes: [String] = []

    var body: some View {
        TabView {
            // First Tab: Filter Perfumes
            FilterPerfumeTab(viewModel: viewModel)

            // Second Tab: Add New Perfume
            AddPerfumeTab(viewModel: viewModel,
                          perfumeName: $perfumeName,
                          perfumeBrand: $perfumeBrand,
                          selectedSeasons: $selectedSeasons,
                          selectedDayTimes: $selectedDayTimes)
            
            // Third Tab: All the collection
            AllPerfumesTab(viewModel: viewModel)
        }
    }
}
