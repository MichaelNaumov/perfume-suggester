// PerfumeViewModel.swift
import Foundation
import Combine

class PerfumeViewModel: ObservableObject {
    @Published var perfumes: [Perfume] = []

    private let storageURL: URL = {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir.appendingPathComponent("perfumes.json")
    }()

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
            try data.write(to: storageURL, options: .atomic)
        } catch {
            print("Error saving perfumes: \(error)")
        }
    }

    private func loadPerfumes() {
        guard let data = try? Data(contentsOf: storageURL), !data.isEmpty else {
            loadSeedData()
            return
        }
        do {
            perfumes = try JSONDecoder().decode([Perfume].self, from: data)
        } catch {
            print("Error loading perfumes: \(error)")
            loadSeedData()
        }
    }

    private func loadSeedData() {
        guard let url = Bundle.main.url(forResource: "seeds", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Seed file 'seeds.json' not found.")
            return
        }
        do {
            perfumes = try JSONDecoder().decode([Perfume].self, from: data)
            savePerfumes()
        } catch {
            print("Error loading seed data: \(error)")
        }
    }
}
