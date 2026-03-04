// FilterPerfumeTab.swift
import SwiftUI

struct FilterPerfumeTab: View {
    @ObservedObject var viewModel: PerfumeViewModel

    @State private var selectedSeason = Date().getCurrentSeason()
    @State private var selectedTimeOfDay = Date().getCurrentTimeOfDay()
    @State private var surprisePerfume: Perfume?

    let seasonEmojis = EmojiData.seasonEmojis
    let dayTimeEmojis = EmojiData.dayTimeEmojis

    private var filteredPerfumes: [Perfume] {
        viewModel.perfumes.filter { perfume in
            let seasonMatch = selectedSeason == "Any" || perfume.seasons.contains(selectedSeason)
            let timeMatch = selectedTimeOfDay == "Any" || perfume.dayTimes.contains(selectedTimeOfDay)
            return seasonMatch && timeMatch
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Season")) {
                    Picker("Season", selection: $selectedSeason) {
                        ForEach(["Any", "Spring", "Summer", "Autumn", "Winter"], id: \.self) { season in
                            Text("\(season) \(seasonEmojis[season] ?? "")")
                        }
                    }
                }

                Section(header: Text("Day Time")) {
                    Picker("Day Time", selection: $selectedTimeOfDay) {
                        ForEach(["Any", "Day", "Night"], id: \.self) { daytime in
                            Text("\(daytime) \(dayTimeEmojis[daytime] ?? "")")
                        }
                    }
                }

                HStack {
                    Spacer()
                    Button("🎁 Surprise Me 🎁") {
                        surprisePerfume = filteredPerfumes.randomElement()
                    }
                    .disabled(filteredPerfumes.isEmpty)
                    Spacer()
                }

                Section(header: Text("Results (\(filteredPerfumes.count))")) {
                    ForEach(filteredPerfumes) { perfume in
                        NavigationLink(destination: PerfumeDetailsView(perfume: perfume)) {
                            PerfumeRow(perfume: perfume)
                        }
                    }
                }
            }
            .navigationTitle("Filter Perfumes")
            .navigationDestination(item: $surprisePerfume) { perfume in
                PerfumeDetailsView(perfume: perfume)
            }
        }
        .tabItem {
            Label("Filter", systemImage: "line.horizontal.3")
        }
    }
}
