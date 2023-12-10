import Foundation

class Perfume: Codable, Identifiable {
    var id = UUID()
    var name: String
    var seasons: [String]
    var dayTimes: [String]
    var brand: String

    init(name: String, seasons: [String], dayTimes: [String], brand: String) {
        self.name = name
        self.seasons = seasons
        self.dayTimes = dayTimes
        self.brand = brand
    }
}
