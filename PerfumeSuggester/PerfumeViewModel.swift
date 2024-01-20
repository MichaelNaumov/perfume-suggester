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
        if let data = UserDefaults.standard.data(forKey: "perfumes"), !data.isEmpty {
            do {
                // Check if the stored data is a valid JSON object
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                guard jsonObject is [Any] else {
                    print("Invalid JSON data in UserDefaults.")
                    loadSeedDataFromJSON()
                    return
                }

                perfumes = try JSONDecoder().decode([Perfume].self, from: data)
                print("Perfumes loaded successfully.")
            } catch {
                print("Error decoding perfumes: \(error)")
                loadSeedDataFromJSON()
            }
        } else {
            loadSeedDataFromJSON()
        }
    }
    
    private func loadSeedDataFromJSON() {
        // Load seed data from a JSON file named "seeds.json"
        if let path = Bundle.main.path(forResource: "seeds", ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            do {
                perfumes = try JSONDecoder().decode([Perfume].self, from: data)
                savePerfumes()
                print("Seed data loaded successfully.")
            } catch {
                print("Error decoding seed data: \(error)")
            }
        } else {
            print("Seed data JSON file 'seeds.json' not found.")
        }
    }

}
