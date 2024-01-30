// FilterPerfumeTab.swift
import SwiftUI

struct FilterPerfumeTab: View {
    @ObservedObject var viewModel: PerfumeViewModel
    
    @State private var selectedSeason = Date().getCurrentSeason()
    @State private var selectedTimeOfDay = Date().getCurrentTimeOfDay()

    let seasonEmojis = EmojiData.seasonEmojis
    let dayTimeEmojis = EmojiData.dayTimeEmojis

    @State private var filteredPerfumes: [Perfume] = []

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Seasons")) {
                    Picker("Season", selection: $selectedSeason) {
                        ForEach(["Any", "Spring", "Summer", "Autumn", "Winter"], id: \.self) { season in
                            Text("\(season) \(seasonEmojis[season] ?? "")")
                        }
                    }
                }

                Section(header: Text("Day Time")) {
                    Picker("Day time", selection: $selectedTimeOfDay) {
                        ForEach(["Any", "Day", "Night"], id: \.self) { daytime in
                            Text("\(daytime) \(dayTimeEmojis[daytime] ?? "")")
                        }
                    }
                }

                Section(header: Text("Filters")) {
                    HStack {
                        Button("Apply Filters") {
                            filteredPerfumes = viewModel.perfumes.filter { perfume in
                                let isSelectedSeason = selectedSeason == "Any" || perfume.seasons.contains(selectedSeason)
                                let isSelectedTimeOfDay = selectedTimeOfDay == "Any" || perfume.dayTimes.contains(selectedTimeOfDay)
                                return isSelectedSeason && isSelectedTimeOfDay
                            }
                        }
                    }

                    Button("Clear Results") {
                        filteredPerfumes.removeAll()
                    }
                }

                HStack {
                    Spacer()
                    Button(action: {
                        if let randomPerfume = viewModel.perfumes.randomElement() {
                            // Handle the selected random perfume (e.g., add to results)
                            filteredPerfumes.removeAll()
                            filteredPerfumes.append(randomPerfume)
                        } else {
                            // No perfumes available
                            print("No perfumes available.")
                        }
                    }) {
                        Text("🎁 Surprise Me 🎁")
                    }
                    Spacer()
                }

                Section(header: Text("Results (\(filteredPerfumes.count))")) {
                    List(filteredPerfumes) { perfume in
                        NavigationLink(
                            destination: PerfumeDetailsView(perfume: perfume),
                            label: {
                                Text("\(perfume.brand) \(perfume.name) - \(perfume.seasons.joined(separator: ", ")) - \(perfume.dayTimes.joined(separator: ", "))")
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
