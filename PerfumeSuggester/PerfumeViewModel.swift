// PerfumeViewModel.swift
import Foundation
import SwiftUI

class PerfumeViewModel: ObservableObject {
    @Published var perfumes: [Perfume] = []

    init() {
        loadPerfumes()
    }

    func addPerfume(name: String, seasons: [String], dayTimes: [String], brand: String) {
        let perfume = Perfume(name: name, seasons: seasons, dayTimes: dayTimes, brand: brand)
        perfumes.append(perfume)
        savePerfumes()
    }
    
    func removePerfumes(atOffsets offsets: IndexSet) {
        perfumes.remove(atOffsets: offsets)
        savePerfumes()
    }

    func savePerfumes() {
        do {
            let data = try JSONEncoder().encode(perfumes)
            UserDefaults.standard.set(data, forKey: "perfumes")
            print("Perfumes saved successfully.")
        } catch {
            print("Error encoding perfumes: \(error)")
        }
    }

    private func loadPerfumes() {
        if let data = UserDefaults.standard.data(forKey: "perfumes") {
            do {
                perfumes = try JSONDecoder().decode([Perfume].self, from: data)
                print("Perfumes loaded successfully.")
            } catch {
                print("Error decoding perfumes: \(error)")
            }
        } else {
            print("No data found for key 'perfumes' in UserDefaults.")
        }
    }
}
