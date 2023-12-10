import Foundation

class Perfume: Codable, Identifiable {
    var id = UUID()
    var name: String
    var seasons: [String]
    var dayTimes: [String]

    init(name: String, seasons: [String], dayTimes: [String]) {
        self.name = name
        self.seasons = seasons
        self.dayTimes = dayTimes
    }
}
