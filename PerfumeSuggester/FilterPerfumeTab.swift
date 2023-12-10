// FilterPerfumeTab.swift
import SwiftUI

struct FilterPerfumeTab: View {
    @ObservedObject var viewModel: PerfumeViewModel
    
//    enum Season: String, CaseIterable, Identifiable {
//        case spring
//        case summer
//        case autumn
//        case winter
//
//        var id: String { self.rawValue }
//    }
    
    @State private var isSpringChecked = false
    @State private var isSummerChecked = false
    @State private var isAutumnChecked = false
    @State private var isWinterChecked = false

    @State private var isDayChecked = false
    @State private var isNightChecked = false
    @State private var selectedSeason = "Spring"
    @State private var selectedDayTime = "Day"
 
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
                    Picker("Day time", selection: $selectedDayTime) {
                        ForEach(["Day", "Night"], id: \.self) { daytime in
                            Text("\(daytime) \(dayTimeEmojis[daytime] ?? "")")
                        }
                    }
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
