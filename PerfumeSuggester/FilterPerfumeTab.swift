// FilterPerfumeTab.swift
import SwiftUI

struct FilterPerfumeTab: View {
    @ObservedObject var viewModel: PerfumeViewModel
    
    @State private var selectedSeason = "Spring"
    @State private var selectedTimeOfDay = "Day"
 
    let seasons = ["Spring", "Summer", "Autumn", "Winter"]

    private let seasonEmojis: [String: String] = [
        "Spring": "🌿",
        "Summer": "⛱️",
        "Autumn": "🍁",
        "Winter": "❄️"
    ]
    
    private let dayTimeEmojis: [String: String] = [
        "Day": "☀️",
        "Night": "🌙"
    ]

    @State private var filteredPerfumes: [Perfume] = []

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Seasons")) {
                    Picker("Season", selection: $selectedSeason) {
                        ForEach(["Spring", "Summer", "Autumn", "Winter"], id: \.self) { season in
                            Text("\(season) \(seasonEmojis[season] ?? "")")
                        }
                    }
                }

                Section(header: Text("Day Time")) {
                    Picker("Day time", selection: $selectedTimeOfDay) {
                        ForEach(["Day", "Night"], id: \.self) { daytime in
                            Text("\(daytime) \(dayTimeEmojis[daytime] ?? "")")
                        }
                    }
                }

                Section(header: Text("Filters")) {
                    HStack {
                        Button("Apply Filters") {
                            filteredPerfumes = viewModel.perfumes.filter { perfume in
                                let isSelectedSeason = selectedSeason.isEmpty || perfume.seasons.contains(selectedSeason)
                                let isSelectedTimeOfDay = selectedTimeOfDay.isEmpty || perfume.dayTimes.contains(selectedTimeOfDay)
                                return isSelectedSeason && isSelectedTimeOfDay
                            }
                        }
                    }

                    Button("Clear Results") {
                        filteredPerfumes.removeAll()
                    }
                }

                Section(header: Text("Perfume Collection")) {
                    List(filteredPerfumes) { perfume in
                        NavigationLink(
                            destination: PerfumeDetailsView(perfume: perfume),
                            label: {
                                Text("\(perfume.brand) \(perfume.name) - \(perfume.seasons.joined(separator: ", ")), \(perfume.dayTimes.joined(separator: ", "))")
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
