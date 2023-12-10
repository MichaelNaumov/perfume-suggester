// ContentView.swift
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: PerfumeViewModel

    // Seasons
    @State private var isSpringChecked = false
    @State private var isSummerChecked = false
    @State private var isAutumnChecked = false
    @State private var isWinterChecked = false

    // Day Times
    @State private var isDayChecked = false
    @State private var isNightChecked = false

    // Filter
    @State private var filteredPerfumes: [Perfume] = []

    // New Perfume
    @State private var perfumeName = ""
    @State private var selectedSeason = "Spring"
    @State private var selectedTimeOfDay = "Day"

    var body: some View {
        TabView {
            // First Tab: Filter Perfumes
            FilterPerfumeTab(viewModel: viewModel)
//                             isSpringChecked: $isSpringChecked,
//                             isSummerChecked: $isSummerChecked,
//                             isAutumnChecked: $isAutumnChecked,
//                             isWinterChecked: $isWinterChecked,
//                             isDayChecked: $isDayChecked,
//                             isNightChecked: $isNightChecked,
//                             filteredPerfumes: $filteredPerfumes)

            // Second Tab: Add New Perfume
            AddPerfumeTab(viewModel: viewModel,
                          perfumeName: $perfumeName,
                          selectedSeason: $selectedSeason,
                          selectedTimeOfDay: $selectedTimeOfDay)
        }
    }
}
