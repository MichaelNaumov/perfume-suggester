// AddPerfumeTab.swift
import SwiftUI

struct AddPerfumeTab: View {
    @ObservedObject var viewModel: PerfumeViewModel
    @Binding var perfumeName: String
    @Binding var selectedSeason: String
    @Binding var selectedTimeOfDay: String

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("New Perfume")) {
                    TextField("Enter Perfume Name", text: $perfumeName)
                }

                Section(header: Text("Seasons")) {
                    ForEach(["Spring", "Summer", "Autumn", "Winter"], id: \.self) { season in
                        Toggle(season, isOn: Binding(
                            get: { selectedSeason == season },
                            set: { _ in selectedSeason = season }
                        ))
                    }
                }

                Section(header: Text("Day Times")) {
                    ForEach(["Day", "Night"], id: \.self) { timeOfDay in
                        Toggle(timeOfDay, isOn: Binding(
                            get: { selectedTimeOfDay == timeOfDay },
                            set: { _ in selectedTimeOfDay = timeOfDay }
                        ))
                    }
                }

                Section {
                    Button("Add Perfume") {
                        viewModel.addPerfume(name: perfumeName, season: selectedSeason, timeOfDay: selectedTimeOfDay)

                        // Clear the text field and reset other fields after adding a perfume
                        perfumeName = ""
                        selectedSeason = "Spring"
                        selectedTimeOfDay = "Day"
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
