// AddPerfumeTab.swift
import SwiftUI

struct AddPerfumeTab: View {
    @ObservedObject var viewModel: PerfumeViewModel
    @Binding var perfumeName: String
    @Binding var selectedSeasons: [String]
    @Binding var selectedDayTimes: [String]
    
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

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("New Perfume")) {
                    TextField("Enter Perfume Name", text: $perfumeName)
                }

                Section(header: Text("Seasons")) {
                    ForEach(["Spring", "Summer", "Autumn", "Winter"], id: \.self) { season in
                        Toggle(isOn: Binding(
                            get: { selectedSeasons.contains(season) },
                            set: { _ in
                                if selectedSeasons.contains(season) {
                                    selectedSeasons.removeAll { $0 == season }
                                } else {
                                    selectedSeasons.append(season)
                                }
                            }
                        )) {
                            // Custom label for the toggle
                            HStack {
                                Text("\(season) \(seasonEmojis[season] ?? "")")
                                Spacer()
                            }
                        }
                    }
                }

                Section(header: Text("Day Times")) {
                    ForEach(["Day", "Night"], id: \.self) { timeOfDay in
                        Toggle(isOn: Binding(
                            get: { selectedDayTimes.contains(timeOfDay) },
                            set: { _ in
                                if selectedDayTimes.contains(timeOfDay) {
                                    selectedDayTimes.removeAll { $0 == timeOfDay }
                                } else {
                                    selectedDayTimes.append(timeOfDay)
                                }
                            }
                        )) {
                            // Custom label for the toggle
                            HStack {
                                Text("\(timeOfDay) \(dayTimeEmojis[timeOfDay] ?? "")")
                                Spacer()
                            }
                        }
                    }
                }

                Section {
                    Button("Add Perfume") {
                        viewModel.addPerfume(name: perfumeName, seasons: selectedSeasons, dayTimes: selectedDayTimes)

                        // Clear the text field and reset other fields after adding a perfume
                        perfumeName = ""
                        selectedSeasons = []
                        selectedDayTimes = []
                    }
                }

                Section(header: Text("Perfume Collection")) {
                    // Display a List of perfumes ordered by name
                    List {
                        ForEach(viewModel.perfumes) { perfume in
                            NavigationLink(
                                destination: PerfumeDetailsView(perfume: perfume),
                                label: {
                                    Text("\(perfume.name) - \(perfume.seasons.joined(separator: ", ")), \(perfume.dayTimes.joined(separator: ", "))")
                                }
                            )
                        }
                        .onDelete { indexSet in
                            // Handle perfume deletion here
                            viewModel.perfumes.remove(atOffsets: indexSet)
                            viewModel.savePerfumes()  // Save changes after deletion
                        }
                    }
                }
            }
            .navigationTitle("Add New Perfume")
        }
        .tabItem {
            Label("Add", systemImage: "plus")
        }
    }
}
