// PerfumeViewModel.swift
import Foundation
import SwiftUI

class PerfumeViewModel: ObservableObject {
    @Published var perfumes: [Perfume] = []

    init() {
        loadPerfumes()
    }

    func addPerfume(name: String, season: String, timeOfDay: String) {
        let perfume = Perfume(name: name, season: season, timeOfDay: timeOfDay)
        perfumes.append(perfume)
        savePerfumes()
    }

    private func savePerfumes() {
        do {
            let data = try JSONEncoder().encode(perfumes)
            UserDefaults.standard.set(data, forKey: "perfumes")
        } catch {
            print("Error encoding perfumes: \(error)")
        }
    }

    private func loadPerfumes() {
        if let data = UserDefaults.standard.data(forKey: "perfumes") {
            do {
                perfumes = try JSONDecoder().decode([Perfume].self, from: data)
            } catch {
                print("Error decoding perfumes: \(error)")
            }
        }
    }
}
