// FilterPerfumeTab.swift
import SwiftUI

struct FilterPerfumeTab: View {
    @ObservedObject var viewModel: PerfumeViewModel
    
    @State private var selectedSeason = "Spring"
    @State private var selectedTimeOfDay = "Day"

    let seasonEmojis = EmojiData.seasonEmojis
    let dayTimeEmojis = EmojiData.dayTimeEmojis

    @State private var filteredPerfumes: [Perfume] = []
    
    var randomPerfume: Perfume? {
        if filteredPerfumes.isEmpty {
            // No filters applied, return a random perfume from the entire collection
            return viewModel.perfumes.randomElement()
        } else {
            // Filters applied, return a random perfume from the filtered collection
            return filteredPerfumes.randomElement()
        }
    }

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

                HStack {
                    Spacer()
                    Button(action: {
                        if let randomPerfume = randomPerfume {
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

                Section(header: Text("Results")) {
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
