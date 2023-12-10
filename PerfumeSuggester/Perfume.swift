// Perfume.swift
import Foundation

class Perfume: Codable, Identifiable {
    var id = UUID()
    var name: String
    var season: String
    var timeOfDay: String

    init(name: String, season: String, timeOfDay: String) {
        self.name = name
        self.season = season
        self.timeOfDay = timeOfDay
    }
}
