// AddPerfumeTab.swift
import SwiftUI

struct AddPerfumeTab: View {
    @ObservedObject var viewModel: PerfumeViewModel

    @State private var perfumeName = ""
    @State private var perfumeBrand = ""
    @State private var selectedSeasons: [String] = []
    @State private var selectedDayTimes: [String] = []
    @FocusState private var isInputActive: Bool

    let seasonEmojis = EmojiData.seasonEmojis
    let dayTimeEmojis = EmojiData.dayTimeEmojis

    private var canSubmit: Bool {
        !perfumeName.trimmingCharacters(in: .whitespaces).isEmpty &&
        !perfumeBrand.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("New Perfume")) {
                    TextField("Perfume Brand", text: $perfumeBrand)
                        .focused($isInputActive)
                    TextField("Perfume Name", text: $perfumeName)
                        .focused($isInputActive)
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
                            HStack {
                                Text("\(seasonEmojis[season] ?? "")  \(season)")
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
                            HStack {
                                Text("\(dayTimeEmojis[timeOfDay] ?? "")  \(timeOfDay)")
                                Spacer()
                            }
                        }
                    }
                }

                Section {
                    Button("Add Perfume") {
                        viewModel.addPerfume(
                            name: perfumeName.trimmingCharacters(in: .whitespaces),
                            seasons: selectedSeasons,
                            dayTimes: selectedDayTimes,
                            brand: perfumeBrand.trimmingCharacters(in: .whitespaces)
                        )
                        perfumeName = ""
                        perfumeBrand = ""
                        selectedSeasons = []
                        selectedDayTimes = []
                        isInputActive = false
                    }
                    .disabled(!canSubmit)
                }
            }
            .navigationTitle("Add New Perfume")
        }
        .tabItem {
            Label("Add", systemImage: "plus")
        }
    }
}
