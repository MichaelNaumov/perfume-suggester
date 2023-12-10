// FilterPerfumeTab.swift
import SwiftUI

struct FilterPerfumeTab: View {
    @ObservedObject var viewModel: PerfumeViewModel

    @State private var isSpringChecked = false
    @State private var isSummerChecked = false
    @State private var isAutumnChecked = false
    @State private var isWinterChecked = false

    @State private var isDayChecked = false
    @State private var isNightChecked = false

    @State private var filteredPerfumes: [Perfume] = []

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Seasons")) {
                    Toggle("Spring", isOn: $isSpringChecked)
                    Toggle("Summer", isOn: $isSummerChecked)
                    Toggle("Autumn", isOn: $isAutumnChecked)
                    Toggle("Winter", isOn: $isWinterChecked)
                }

                Section(header: Text("Day Times")) {
                    Toggle("Day", isOn: $isDayChecked)
                    Toggle("Night", isOn: $isNightChecked)
                }

                Section(header: Text("Filters")) {
                    Button("Apply Filters") {
                        filteredPerfumes = viewModel.perfumes.filter { perfume in
                            let selectedSeasons = [isSpringChecked, isSummerChecked, isAutumnChecked, isWinterChecked]
                            let selectedDayTimes = [isDayChecked, isNightChecked]

                            return (selectedSeasons[0] && perfume.season.contains("Spring")) ||
                                   (selectedSeasons[1] && perfume.season.contains("Summer")) ||
                                   (selectedSeasons[2] && perfume.season.contains("Autumn")) ||
                                   (selectedSeasons[3] && perfume.season.contains("Winter")) ||
                                   (selectedDayTimes[0] && perfume.timeOfDay.contains("Day")) ||
                                   (selectedDayTimes[1] && perfume.timeOfDay.contains("Night"))
                        }
                    }
                }

                Section(header: Text("Perfume Collection")) {
                    List(filteredPerfumes) { perfume in
                        NavigationLink(
                            destination: PerfumeDetailsView(perfume: perfume),
                            label: {
                                Text("\(perfume.name) - \(perfume.season), \(perfume.timeOfDay)")
                            }
                        )
                    }
                }
            }
            .navigationTitle("Filter Perfumes")
        }
        .tabItem {
            Label("Filter", systemImage: "line.horizontal.3")
        }
    }
}
