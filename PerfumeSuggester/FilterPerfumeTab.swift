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
                    Button("Apply Filters") {
                        filteredPerfumes = viewModel.perfumes.filter { perfume in
                            return (selectedSeason == "Spring" && perfume.season.contains("Spring")) ||
                                   (selectedSeason == "Summer" && perfume.season.contains("Summer")) ||
                                   (selectedSeason == "Autumn" && perfume.season.contains("Autumn")) ||
                                   (selectedSeason == "Winter" && perfume.season.contains("Winter")) ||
                                   (selectedTimeOfDay == "Day" && perfume.timeOfDay.contains("Day")) ||
                                   (selectedTimeOfDay == "Night" && perfume.timeOfDay.contains("Night"))
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
